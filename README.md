# AGISIT Project Team 29 - Online Boutique Store using Terraform and Vagrant

![online-Boutique screenshot]()

## Description

This project was done using Terraform and Kubernetes, inspired by the Google Cloud Platform microservices-demo project (https://github.com/GoogleCloudPlatform/microservices-demo)

First, we build the Docker images using the GCP-demo Dockerfile and upload them to a dockerhub.io repository[https://hub.docker.com/r/ricardojss/agisit-team29/tags]. We choose to use Terraform as an Infrastructure-as-Code tool to deploy our Kubernetes cluster to a cloud provider.
To do so, we created several Terraform files including the k8s-pods.tf that describes the Kubernetes pods that are used the Dockerimages to specify the microservices. It also includes information about the ports, the environments variables and the number of replicas (we choose 3).
We also created the k8s-services.tf to defines the services for each microservices and the gcp-gke-cluster.tf file to define the cluster where the Kubernetes cluster will be deployed (GCP). In order to facilitate the installation, we provide a Vagrant VM with all the necessary packages already installed.

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

### First Steps (for every Cloud Provider)

#### 1 - Clone or download the repository to your computer

#### 2 - Open a Terminal or Shell window in the repository folder

#### 3 - Install Vagrant

#### 4 - Execute the following command -> export VAGRANT_VAGRANTFILE="Vagrantfile.vbox"

#### 5 - Bring the VM up with -> vagrant up

#### 6 - Connect with the VM -> vagrant ssh mgmt

#### 7 - Now, read the instructions below according to your cloud provider

### In Google Cloud Platform

#### Connect with the project
`gcloud auth application-default login`

1) Download the credentials from GCP
2) Update the terraform.tfvars and gcp-gke-provier.tf file to match with your GCP project
3) Deploy with terraform init / terraform plan / terraform apply
4) Go to GCP -> Kubernetes Engine -> Services & Ingress page to obtain the IP address of the Boutique

### In another cloud provider
1) Download the credentials
2) Update the gcp-gke-cluster.tf file to match the desired cloud provider
2) Update the terraform.tfvars and gcp-gke-provier.tf file to match with your GCP project
3) Deploy with terraform init / terraform plan / terraform apply
4) Check the correct deployment by consulting the front-end endpoint IP
