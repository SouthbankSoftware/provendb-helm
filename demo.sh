#doitlive speed: 10
#doitlive commentecho: true

#1. Show version inside Charts.yml file for provendb-api-gateway
echo ""

#2. Now packaging provendb-api-gateway (only infra code)
helm package charts/provendb-api-gateway

#3. List the generated tar file
ls | grep provendb-api-gateway-1.0.0.tgz

#4. List helm repo locations on local
helm repo list

#5. Push the packaged tar ball 
helm gcs push provendb-api-gateway-1.0.0.tgz provendb-helm

#6. Update local helm repo
helm repo update

#7. Repeat the same for other modules
helm package charts/provendb-concierge && helm gcs push provendb-concierge-1.0.0.tgz provendb-helm && helm package charts/provendb-proxy && helm gcs push provendb-proxy-1.0.0.tgz provendb-helm && helm package charts/provendb-tree && helm gcs push provendb-tree-1.0.0.tgz provendb-helm && helm package charts/provendb-user && helm gcs push provendb-user-1.0.0.tgz provendb-helm && helm package charts/provendocs && helm gcs push provendocs-1.0.0.tgz provendb-helm &&  helm package charts/provendb-io && helm gcs push provendb-io-1.0.0.tgz provendb-helm &&  helm package charts/provendb-ui && helm gcs push provendb-ui-1.0.0.tgz provendb-helm && helm repo update

#8. Clean local directory
rm -rf *.tgz

#9. Show requirements.yml file
echo ""

#10. Show dependencies
helm dependency list

#11. Download dependencies
helm dependency build

#12. Package the parent chart with all it's dependencies
helm package .

#13. Push this chart
helm gcs push provendb-helm-1.0.0.tgz provendb-helm && helm repo update

#14. Now deploy this chart
helm install --name=provendb --namespace=staging provendb-helm-1.0.0.tgz






