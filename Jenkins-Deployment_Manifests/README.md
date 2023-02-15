# Kubernetes Manifests for Jenkins Deployment

## first attach to cluster 

```
aws eks --region <region> update-kubeconfig --name <clusterName> --profile <profileName That Used While Creating Cluster>
```
## apply Yaml Files using kubectl

```
kubectl apply -f namespace.yaml
kubectl apply -f serviceAccount.yaml
kubectl create -f volume.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

* Happy jenkins :tada: :tada:
