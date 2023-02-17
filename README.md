# ITI final Project
## Project Info.

This project contains:
*  Infrastructure as code using [Terraform](https://www.terraform.io/) that builds an environment on the AWS cloud platform
* [Kubernetes](https://kubernetes.io) Jenkins-Deployment_Manifests YAML files for deploying jenkins
* Demo app with Dockerfile
* [Kubernetes](https://kubernetes.io) Using the demo app from [My_Connect-4_repo](https://github.com/AmrTarek17/Connect-4)

## Tools Used

* [Terraform](https://www.terraform.io/)
* [AWS](https://aws.amazon.com/)
* [Docker](https://www.docker.com/)
* [kubernetes](https://kubernetes.io)
* [Jenkins](https://www.jenkins.io/)


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
    cd iti-project/terraform
    ```

    ``` 
    terraform init
    terraform apply
    ```
    that will build:
    
    * VPC named "prod-vpc"
    * 2 public Subnets
    * 2 private Subnets
    * 2 nat gateway   
    * EKS private Kubernetes cluster
    * 1 ec2 used as bastion and slave for jenkins


    ## configure config map on ec2 and add your role 

    ```
    - groups:
      - system:masters
      rolearn: arn:aws:iam::<change all arn with yours>:role/ec2-eks
      username: basion-admin
    ```

        ```bash
        # NOTE
        You need to get attached to cluster using.
        aws eks --region <region> update-kubeconfig --name <clusterName> 
        ```
### deploy jenkins with ansible playbook
![image](https://user-images.githubusercontent.com/47079437/219532656-3f194073-ff30-4af8-8432-ca879bbdbe88.png)

![image](https://user-images.githubusercontent.com/47079437/219531956-6e147679-2f75-4f66-9fb1-2e75864cd8e7.png)

### or deploy jenkins from /Jenkins-Deployment_Manifests using Readme.md there then

```
kubect exec -it <jenkins_pod_name> bash
```
* cat the admin password file and use it to create your own
* hit install recomended
* fork my repo [My_Connect-4_repo](https://github.com/AmrTarek17/Connect-4)
* edit IMG_NAME variable from Jenkinsfile there
* configure your docker hub credintials on jenkins with credentialsId: 'Docker_Hub'
* configure your ec2 ssh credintial with the private key that terraform created for you "You can locate it in secrets manger from console"
![image](https://user-images.githubusercontent.com/47079437/219493823-c4a459d1-b4e9-4155-862e-d30d6d4a8d08.png)

![image](https://user-images.githubusercontent.com/47079437/219493459-873d6f82-3da7-493f-be1c-745948ff54e9.png) 
* configure your pipeline
![image](https://user-images.githubusercontent.com/47079437/219491485-e5fc1562-eccb-49d8-8481-39f2888c5336.png)

* Run your pipeline
![image](https://user-images.githubusercontent.com/47079437/219494215-fce9ebb2-9c8e-4fad-ba47-67f5ddfb4bc4.png)

---
Now, you can access the Demo App by hitting the Ingress IP 

You can try my deployed demo Game from [here](http://acb4cfa3ebe4d4ae9bd2fe194826c862-a734eb8b1c4c9f8e.elb.us-west-2.amazonaws.com)

You can try my deployed jenkins from [here](http://ad3a734130a6244859985054ce946913-1362118519.us-west-2.elb.amazonaws.com:8080)
```User:admin```,```Pass:admin```

:tada: :tada: :tada: :tada:
