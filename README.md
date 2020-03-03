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

Cloud: GCP, Azure, Minikube and Kubernetes on docker desktop

Note: Most of the important configuration can be set by modifying values in the root `values.yaml` file. e.g. underlying infrastrcture, port numbers etc.

You can install the helm chart in any one of the following two ways:

# I. Running ProvenDB from the packaged helm chart

Configure provendb helm repo location

1. 
```
helm repo add provendb https://www.dbkoda.com/provendb-helm/
```
2. Update Helm repo cache
```
helm repo update
```
3. Fetch the chart
```
helm fetch provendb/provendb-helm
```
4. 
```
helm install --name=suku --namespace=prd  provendb-helm-*.tgz
```
5. Continue from Step 3 in the next section.

# II. Running ProvenDB from the git repo

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

4b. Otherwise, e.g. on minikube/kubernetes on docker desktop, you can do port forwarding like the following:
```
kubectl port-forward pods/suku-provendb-proxy-statefulset-0 27018:27018 -n prd
```
The IP address in this case will be `localhost` and port number `27018`

5. Then you can connect to the proxy using this command:
```
mongo mongodb://admin:password@<ipaddress>:<port>/provendb
```

6. You should now be able to connect to proxy and create and submit proofs.



Limitations:
============
1. The connection to provendb proxy is non-ssl.
2. Some of the configuration is different for each cloud provider. This helm chart has been tested on GCP, Azure and minikube.

