# Helm Chart Deployment of ProvenDB
---
This chart bootstraps a [ProvenDB](https://provendb.com) deployment on a Kubernetes cluster using the Helm package manager.


## Table of Contents
- [Helm Chart Deployment of ProvenDB](#helm-chart-deployment-of-provendb)
  - [Table of Contents](#table-of-contents)
  - [Prerequisities](#prerequisites)
  - [Compatibility](#compatibility)  
  - [Installation](#installation)
    - [1. Running ProvenDB from already packaged helm chart](#i-running-provendb-from-the-packaged-helm-chart)
    - [2. Running ProvenDB from the Helm chart source code in this repo](#ii-running-provendb-from-the-helm-chart-source-code-in-this-repo)
- [Configuration](#configuration)
- [Tear Down](#tear-down)
- [Limitations](#limitations)
- [Contact](#contact)

## Prerequisites:

1. You should have a kubernetes cluster running and `kubectl` should point to it.
2. There should be `helm3.x` installed on the client machine. For instructions, you can refer here https://helm.sh/docs/intro/install/
4. Make sure you have enough resources in the k8s cluster. The following works on minikube
```
minikube start  --cpus=6 --memory=8000mb
```

## Compatibility

|                       |                                                         |
| ----------------------- | :------------------------------------------------------------------: |
| **Kubernetes**      | 1.16.7 |
| **Helm client**      |           3.2.0            |
| **Underlying Infrastructure** |             GCP, Azure, Minikube and Kubernetes on Docker Desktop for Mac              |

## Installation 

If you have a previously installed this chart and want to test the udpated helm chart, make sure you follow [Tear Down ](#tear-down) first.

You can install the helm chart in any one of the following two ways:



### Running ProvenDB from the Helm chart source code in this repo

1. Download dependencies

Inside the `provendb-helm` repository
```
helm dependency update
```
This will download the mongodb helm chart which is the only dependency.

2. Install the helm charts

First, create the necessary namespace
```
kubectl create namespace prd
helm install myprovendb --namespace=prd  . --set global.cloud=MINIKUBE
```
The release name can be anything. In this case myProvenDB.
By default, the config is set for `kubernetes on docker  desktop`. If you would like to change this, you can do it in the following way for instance for minikube:
```
helm install myprovendb --namespace=prd  . --set global.cloud=MINIKUBE
```
Please refer `values.yaml` to see other options available.

3. If you run `kubectl get pods -n prd`, you should see the list of pods. They might error initially, but eventually they should all be healthy.

4a. On cloud providers that support load balancers, an external IP address would be provisioned to access the proxy service. You can get the external IP for the proxy service by running the folowing:
```
kubectl get svc myprovendb-provendb-proxy-service -n prd
```
and checking the EXTERNAL-IP field. The default port to connect to is 27018

4b. Otherwise, e.g. on minikube/kubernetes on docker desktop, you can do port forwarding like the following:
```
kubectl port-forward pods/myprovendb-provendb-proxy-statefulset-0 27018:27018 -n prd
```
The IP address in this case will be `localhost` and port number `27018`

5. Then you can connect to the proxy using this command:
```
mongo mongodb://admin:password@localhost:27018/provendb
```
You can configure the credentials in the root `values.yaml` file

6. You should now be able to connect to proxy and create and submit proofs.

# Using Proxy

Once you have all the services marked as healthy, you can connect to proxy and submit proofs. By default, anchoring to only Ethereum testnet is configured. You can refer [values.yaml](values.yaml) here to support other blockchains.

```
mongo mongodb://admin:password@<ipaddress>:<port>/provendb
db.runCommand({submitProof: 1, anchorType: "ETH" })
db.runCommand({getProof: "<proofID>"})
```

# Configuration

Most of the important configuration can be set by modifying values in the root `values.yaml` file. e.g. underlying infrastrcture, port numbers, credentials etc.

# Tear Down

To tear down the setup down, simply
1. Delete the helm the helm release
```
helm delete myProvenDB -n prd
```
2. Delete the pvcs associated with it
```
kubectl delete $(kubectl get pvc -n prd -o name | grep myProvenDB ) -n prd
```


# Limitations:

1. The connection to provendb proxy is non-ssl.
2. Some of the configuration is different for each cloud provider. This helm chart has been tested on [GCP](https://cloud.google.com/, [Azure](https://azure.microsoft.com/en-au/), [Minikube](https://kubernetes.io/docs/setup/learning-environment/minikube/) and [Kubernetes on Docker Desktop](https://www.docker.com/blog/kubernetes-is-now-available-in-docker-desktop-stable-channel/).

# Contact

If you run into any issues, or wish to discuss a custom deployment of ProvenDB for your blockchain project, please email us at **support@southbanksoftware.com**

_Copyright © 2019,2022 Southbank Software. All rights reserved._
