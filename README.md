# Helm Chart Deployment of ProvenDB

<div align="center">

[![Powered by ProvenDB](https://img.shields.io/static/v1.svg?label=Powered%20By&message=ProvenDB&color=35b3d4&labelColor=1c4d6b&link=https:/provendb.com&link=https:/provendb.com&logo=data:image/png;base64,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)](https://img.shields.io/static/v1.svg?label=Powered%20By&message=ProvenDB&color=35b3d4&labelColor=1c4d6b&link=https:/provendb.com&link=https:/provendb.com&logo=data:image/png;base64,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)

</div>

---

This chart bootstraps a [ProvenDB](https://provendb.com) deployment on a Kubernetes cluster using the Helm package manager.
---
## Table of Contents
- [Helm Chart Deployment of ProvenDB](#helm-chart-deployment-of-provendb)
  - [Table of Contents](#table-of-contents)
  - [Prerequisities](#prerequisities)
  - [Compatibility](#compatibility)  
  - [Installation](#installation)
    - [I. Running ProvenDB from already packaged helm chart](#running-provendb-from-the-packaged-helm-chart)
    - [II. Running ProvenDB from the Helm chart source code in this repo](#running-provendb-from-the-helm-chart-source-code-in-this-repo)
- [Configuration](#configuration)
- [Tear Down](#tear-down)
- [Limitations](#limitations)
- [Contact](#contact)

## Prerequisites:

1. You should have a kubernetes cluster running and `kubectl` should point to it. 
2. There should be `helm2.x` installed on the client machine. For instructions, you can refer here https://helm.sh/docs/intro/install/
3. The kubernetes cluster should have `tiller` installed. For installation of tiller, please refer https://codereviewvideos.com/course/installing-kubernetes-rancher-2-terraform/video/install-tiller-kubernetes-cluster
4. Make sure you have enough resources in the k8s cluster. The following works on minikube
```
minikube start --kubernetes-version=1.14.4 --cpus=6 --memory=8000mb
```

## Compatiblity
| Platform                      |                             Version                            |
| ----------------------- | :------------------------------------------------------------------: |
| **Kubernetes**      | 1.14.4 |
| **Helm client**      |           2.14.3            |
| **Underlying Infrastructure** |             GCP, Azure, Minikube and Kubernetes on Docker Desktop for Mac              |

## Installation 

You can install the helm chart in any one of the following two ways:

### I. Running ProvenDB from the packaged helm chart

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
By default, the config is set for `kubernetes on docker  desktop`. If you would like to change this, you can do it in the following way for instance for minikube:
```
helm install --name=suku --namespace=prd  provendb-helm-*.tgz --set global.cloud=MINIKUBE
```
Please refer `values.yaml` to see other options available.

5. Continue from Step 3 in the next section.

### II. Running ProvenDB from the Helm chart source code in this repo

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
By default, the config is set for `kubernetes on docker  desktop`. If you would like to change this, you can do it in the following way for instance for minikube:
```
helm install --name=suku --namespace=prd  . --set global.cloud=MINIKUBE
```
Please refer `values.yaml` to see other options available.

3. If you run `kubectl get pods -n prd`, you should see the list of pods. They might error initially, but eventually they should all be healthy.

4a. On cloud providers that support load balancers, an external IP address would be provisioned to access the proxy service. You can get the external IP for the proxy service by running the folowing:
```
kubectl get svc suku-provendb-proxy-service -n prd
```
and checking the EXTERNAL-IP field. The default port to connect to is 27017

4b. Otherwise, e.g. on minikube/kubernetes on docker desktop, you can do port forwarding like the following:
```
kubectl port-forward pods/suku-provendb-proxy-statefulset-0 27017:27018 -n prd
```
The IP address in this case will be `localhost` and port number `27017`

5. Then you can connect to the proxy using this command:
```
mongo mongodb://admin:password@<ipaddress>:<port>/provendb
```
You can configure the credentials in the root `values.yaml` file

6. You should now be able to connect to proxy and create and submit proofs.

# Configuration

Most of the important configuration can be set by modifying values in the root `values.yaml` file. e.g. underlying infrastrcture, port numbers, credentials etc.

# Tear Down

To tear down the setup down, simply
1. Delete the helm the helm release
```
helm delete suku --purge
```
2. Delete the pvcs associated with it
```
kubectl delete $(kubectl get pvc -n prd -o name | grep suku ) -n prd
```


# Limitations:

1. The connection to provendb proxy is non-ssl.
2. Some of the configuration is different for each cloud provider. This helm chart has been tested on GCP, Azure and minikube.

# Contact

If you run into any issues, or wish to discuss a custom deployment of ProvenDB for your blockchain project, please email us at **support@southbanksoftware.com**

_Copyright © 2019 Southbank Software. All rights reserved._
