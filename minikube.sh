# Quick setup on minikube
minikube start --cpus=6 --memory=12000mb --profile=miniProven  --driver=hyperkit
helm repo add provendb https://www.dbkoda.com/provendb-helm/
rm  provendb-helm-*.tgz
helm fetch provendb/provendb-helm
helm install provendb provendb-helm-*.tgz --set global.cloud=MINIKUBE

# Wait until everything is up
let down=1
while [  $down -ge 1 ];do
    let down=0
    kubectl get pods|tail -n +2|while read LINE;do
        podstatus=`echo $LINE|awk '{print $3}'`
        echo $podstatus
        if [ "$podstatus" != "Running" ] && [ $podstatus != "Completed" ]; then 
            let down=$down+1
        fi;
    done
    sleep 5
done

kubectl port-forward pods/provendb-provendb-proxy-statefulset-0 27018:27018  &
export PROVENDB_URI=mongodb://admin:password@localhost:27018/provendb
mongo $PROVENDB_URI
