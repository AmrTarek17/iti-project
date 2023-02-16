# Kubernetes Manifests for Jenkins Deployment

## first attach to cluster 

    ```bash
    # NOTE
    You need to get attached to cluster using.
    aws eks --region <region> update-kubeconfig --name <clusterName> --profile <profileName That Used While Creating Cluster>
    ```
## apply Yaml Files using kubectl

```
kubectl apply -f namespace.yaml
kubectl apply -f serviceAccount.yaml
```
## edit values in volume yaml file with your node name in line 33 using ```kubectl get nodes``` then continue
```
kubectl create -f volume.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

* Happy jenkins :tada: :tada:
