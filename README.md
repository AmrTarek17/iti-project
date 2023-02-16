# ITI final Project
## Project Info.

This project contains:
*  Infrastructure as code using [Terraform](https://www.terraform.io/) that builds an environment on the AWS cloud platform
* jenkins custome image Dockerfile
* [Kubernetes](https://kubernetes.io) YAML files for deploying jenkins
* Demo app with Dockerfile
* [Kubernetes](https://kubernetes.io) YAML files for deploying the demo app

## Tools Used

* [Terraform](https://www.terraform.io/)
* [AWS](https://aws.amazon.com/)
* [Docker](https://www.docker.com/)
* [kubernetes](https://kubernetes.io)
* [python](https://www.python.org)


## Get Started

### Get The Code 
* Using [Git](https://git-scm.com/), clone the project.

    ```
    git clone https://github.com/AmrTarek17/iti-project.git
    ```
### Setup Infra
* First setup your aws account with cli.

* Second build the infrastructure by run

    ```bash
    cd iti-project/
    ```

    ``` 
    terraform init
    terraform apply
    ```
    that will build:
    
    * VPC named "main"
    * 2 public Subnets
    * 2 private Subnets
    * 1 nat gateway   
    * Kubernetes cluster named "my-eks"

        ```bash
        # NOTE
        You need to get attached to cluster using.
        aws eks --region <region> update-kubeconfig --name <clusterName> --profile <profileName That Used While Creating Cluster>
        ```
### to Build & Push Docker custome-jenkins-Image to docker hub
* Build the Docker Image by run

    ```bash
    cd Dockerfiles

    docker build -t <dockerHub-UserID>/<image-name>:<image-version> .
    docker push <dockerHub-UserID>/<image-name>:<image-version>
    ```


### deploy jenkins from /Jenkins-Deployment_Manifests using Readme.md there

### configure jenkins with eks

* first install and apply kubernetes plugin
    ![image](https://user-images.githubusercontent.com/47079437/218911770-192df886-8f49-403a-b4ce-d7a0e72950c3.png)
* run ```kubectl cluster-info``` for control plan url
* run ```kubectl describe secret $(kubectl describe serviceaccount jenkins-admin --namespace=devops-tools | grep Token | awk '{print $2}') --namespace=devops-tools``` for token
* run ```kubectl create rolebinding jenkins-admin-binding --clusterrole=jenkins-admin --serviceaccount=jenkins-admin:jenkins-admin --namespace=devops-tools``` for role binding

### with all of this add cloud kubernetes from manage nodes and clouds

![image](https://user-images.githubusercontent.com/47079437/218913754-62650677-2918-4cd3-9b35-a7e8536d4338.png)

### Build & Push Docker Image to GCR
* Build the Docker Image by run

    ```bash
    docker build -t eu.gcr.io/<PROJECT-ID>/my-app:1.0 src/
    ```
* pull Redis image and tag it
    ```bash
    docker pull redis:5.0
    docker tag redis:5.0 eu.gcr.io/<PROJECT-ID>/redis:5.0
    ```
* Setup credentials for docker to Push to GCR using "docker-gcr-sa" Service Account

    ```
    gcloud auth activate-service-account docker-gcr-sa --key-file=KEY-FILE
    gcloud auth configure-docker
    ```
* Push the Images to GCR

    ```
    docker push eu.gcr.io/<PROJECT-ID>/my-app:1.0
    docker push eu.gcr.io/<PROJECT-ID>/redis:5.0
    ```

### Deploy
* After the infrastructure got built, now you can login to the "management-vm" VM using SSH then:
    
    * setup cluster credentials
        ```
        gcloud container clusters get-credentials app-cluster --zone europe-west1-c --project <PROJECT-ID>
        ```
    * Change image in "k8s-yaml-files/deployments/app-deployment.yaml" with your image

    * Change image in "k8s-yaml-files/deployments/redis-pod.yaml" with your image

    * Upload the "k8s-yaml-files" dir to the VM and run
    
        ```
        kubectl apply -f k8s-yaml-files/
        ```

        that will deploy:
        
        * Config Map for environment variables used by demo app
        * Redis Pod and Exopse the pod with ClusterIP service
        * Demo App Deployment and Exopse it with NodePort service
        * Ingress to create HTTP loadbalancer

---
Now, you can access the Demo App by hitting the Ingress IP 

You can try my deployed demo from [here](http://34.160.145.6/)
And you can brows my Demo ScreenShots folder from GCP-Terraform/ScreenShots