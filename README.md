# AGISIT Project Team 29 - Online Boutique Store using Terraform and Vagrant

![online-Boutique screenshot]()

## Project and solution Description

This project was implemented using Vagrant, Terraform and Kubernetes and inspired by the Google Cloud Platform microservices-demo project (https://github.com/GoogleCloudPlatform/microservices-demo)

First, we build the Docker images using the GCP-demo Dockerfiles for the different microservices and upload them to a dockerhub.io repository[https://hub.docker.com/r/ricardojss/agisit-team29/tags]. We choose to use Terraform as an Infrastructure-as-Code tool to deploy our Kubernetes cluster to a cloud provider.
To do so, we created several Terraform files including the k8s-pods.tf that describes the Kubernetes pods that are used the Dockerimages to specify the microservices. It also includes information about the ports, the environments variables and the number of replicas (we choose 3).
We also created the k8s-services.tf to defines the services for each microservices and the gcp-gke-cluster.tf file to define the cluster where the Kubernetes cluster will be deployed (GCP). In order to facilitate the installation, we provide a Vagrant VM with all the necessary packages already installed. Additionally, monitoring tools were also introduced (Grafana and Prometheus) to allow real time monitoring of the cluster. Finally, we have made the application with high availability by replicating the pods (3 replicas for each pode, execept the redis-leader) and also introduced persistent storage by introducing a redis-leader and redis-follower pods.

## The architecture of the application

<img width="639" alt="Captura de ecrã 2022-11-04, às 15 01 01" src="https://user-images.githubusercontent.com/56162588/200007286-93264a2e-47c3-403c-abf7-cbf135205e6e.png">


#### Microservices available to the client
The application is a web-based e-commerce app where users can browse items, add them to the cart, and purchase them. It includes 10 microservices:
- adservice
- cartservice
- checkoutservice
- currencyservice
- emailservice
- frontend
- paymentservice
- productcatalogservice
- recommendationservice
- shippingservice

#### Maintenance Services and DB Services
- grafana
- prometheus
- istiod
- redis-leader
- redis-follower

## Deployment Instructions

### First Steps

### In Google Cloud Platform
1) Download the credentials from GCP to the terraform folder
2) Update the terraform.tfvars and gcp-gke-provider.tf file to match with your GCP project and credential files name

### In another cloud provider
1) Download the credentials
2) Update the gcp-gke-cluster.tf file to match the desired cloud provider
3) Update the terraform.tfvars and gcp-gke-provier.tf file to match with your cloud provider project

### 
1) Clone or download the repository to your computer

2) Open a Terminal or Shell window in the repository folder

3) Install Vagrant

4) Execute the following command $export VAGRANT_VAGRANTFILE="Vagrantfile.vbox"

5) Bring the VM up with $vagrant up

6) Connect with the VM $vagrant ssh mgmt

7) Access the terraform folder $cd terraform

8) Connect to your project (in Google Cloud use gcloud auth login followed by gcloud config set project <name-of-your-project>
  
9) Initialize Terraform $terraform init
  
10) Plan the deployment $terraform plan
  
11) If no errors are reported apply the changes $terraform apply
  
12) If everything went rigth, the application is now deployed (check the ingress IP in the Dashport of your Cloud Provider)! Enjoy our store!
