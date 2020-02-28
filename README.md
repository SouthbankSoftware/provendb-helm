# Prerequisite:

1. You should have a kubernetes cluster running and `kubectl` should point to it. 
2. There should be `helm2.x` installed on the client machine. For instructions, you can refer here https://helm.sh/docs/intro/install/
3. The kubernetes cluster should have `tiller` installed. For installation of tiller, please refer https://codereviewvideos.com/course/installing-kubernetes-rancher-2-terraform/video/install-tiller-kubernetes-cluster
4. Make sure you have enough resources in the k8s cluster. The following works on minikube
```
minikube start --kubernetes-version=1.14.4 --cpus=6 --memory=8000mb
```

# Tested on: ###
kubernetes version: 1.14.4

Helm version: 2.14.3

Cloud: GCP, Azure and Minikube

# Running ProvenDB from the packaged helm chart

The public helm repository for provendb is location on GCP. 

1. Install the helm gcs plugin from here
2. Add your repository to Helm
```
helm repo add provendb  gs://provendb-helm-charts
```
3. Update Helm cache
```
helm repo update
```
4. Fetch the chart
```
helm fetch provendb/provendb-helm
```
5. Continue from Step 2 in the next section.


# Running ProvenDB from the git repo

1. Download dependencies

Inside the `provendb-helm` repository
```
helm dependency update
```
This will download the mongodb helm chart which is the only dependency.

2. Install the helm charts
```
helm install --name=suku --namespace=prd  .
```
The release name can be anything. In this case suku.

3. If you run `kubectl get pods -n prd`, you should see the list of pods. They might error initially, but eventually they should all be healthy.

4a. On cloud providers that support load balancers, an external IP address would be provisioned to access the proxy service. You can get the external IP for the proxy service by running the folowing:
```
kubectl get svc suku-provendb-proxy-service -n prd
```
and checking the EXTERNAL-IP field. The default port to connect to is 27017

4b. Otherwise, e.g. on minikube, you can do port forwarding like the following:
```
minikube service suku-provendb-proxy-service -n prd
```
Looks for the IP address and the port corresponding to `mongo-suku-provendb-proxy-port`

5. Then you can connect to the proxy using this command:
```
mongo mongodb://admin:password@<ipaddress>:<port>/provendb
```

6. You should now be connect to proxy and create and submit proofs.

Note: Most of the important configuration can be overriden by modifiying values in the root `values.yaml` file.

Limitations:
============
1. The connection to provendb proxy is non-ssl.
2. Some of the configuration is different for each cloud provider. This helm chart has been tested on GCP, Azure and minikube.

