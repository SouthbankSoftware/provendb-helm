Note: Currently, only helm charts for `provendb-proxy` are working.

To use the helm charts for `provendb-proxy` you need to do the following:

### Fetch helm charts from repository

1. The helm charts have been packaged into a tar ball and upload on a helm chart repository. We will be using GCS as our helm chart repo.
2. In order to be able to push and pull, you need to authenticate to GCS repo. I have created a `serviceaccount` for the same. Please ask for the credentials file if you need to use this chart.
3. We use this plugin to push and pull charts. https://github.com/nouney/helm-gcs. Please check the README there to fetch the tar ball.
In our case, 
```
repo-name = provendb-helm
chart = proxy-helm
```
So, to fetch `proxy-helm`, you may run the following command:
```
helm fetch provendb-helm/proxy-helm
```
After this, `proxy-helm-0.1.0.tgz` should be downloaded which is the tar ball for `proxy` chart.

PS: If you face any issue accessing to GCS, you can download the tar ball `proxy-helm-0.1.0.tgz` from github itself.
https://github.com/SouthbankSoftware/provendb-helm/blob/master/charts/proxy-helm/proxy-helm-0.1.0.tgz

### Using the tar ball

__PREREQUISITE__: You should have `gcloud` and `kubectl` installed. Use `developer` account for `gcloud`.

Once you have downloaded the tar ball, you can use to setup `k8s` environment like the following:
1. Connect to a `k8s` cluster. In order to connect to the `staging` cluster, use this command 
```
gcloud container clusters get-credentials provendb --zone australia-southeast1-a --project provendb
```
2. You can now install the helm chart like the following
```
helm install --name provendb --namespace dev proxy-helm-0.1.0.tgz
```
You can override these values https://github.com/SouthbankSoftware/provendb-helm/blob/master/charts/proxy-helm/values.yaml when using the above command

The above will generate the following output
```
NAME:   provendb
LAST DEPLOYED: Fri Dec 21 00:13:15 2018
NAMESPACE: dev
STATUS: DEPLOYED

RESOURCES:
==> v1/Secret
NAME                    AGE
provendb-proxy-secrets  0s

==> v1/ConfigMap
provendb-proxy-configmap  0s

==> v1/Service
provendb-proxy-service  0s

==> v1/Deployment
provendb-proxy  0s

==> v1/Pod(related)

NAME                             READY  STATUS             RESTARTS  AGE
provendb-proxy-66455f984d-62lxz  0/1    ContainerCreating  0         0s


NOTES:
1. Get the application URL by running these commands:
     NOTE: It may take a few minutes for the LoadBalancer IP to be available.
           You can watch the status of by running 'kubectl get svc -w provendb-proxy-helm'
  export SERVICE_IP=$(kubectl get svc --namespace dev provendb-proxy-helm -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
  echo http://$SERVICE_IP:27018
```

After a while, you should be able to access proxy using the following command:
```
mongo $SERVICE_IP:27018
```





