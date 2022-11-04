# AGISIT Project Team 29 - Online Boutique Store using Terraform and Vagrant

<img width="1436" alt="Captura de ecrã 2022-11-04, às 15 15 30" src="https://user-images.githubusercontent.com/56162588/200010419-fc773aae-b801-498d-8f4e-e9f9eb097827.png">

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

1) Clone or download the repository to your computer

2) Open a Terminal or Shell window in the repository folder

3) Install Vagrant

### Initial Configurations

#### If you are using Google Cloud Platform
1) Download the credentials from GCP to the terraform folder
2) Update the terraform.tfvars and gcp-gke-provider.tf file to match with your GCP project and credential files name

#### If your are using another cloud provider
1) Download the credentials to the terraform folder
2) Update the gcp-gke-cluster.tf file to match the desired cloud provider
3) Update the terraform.tfvars and gcp-gke-provier.tf file to match with your cloud provider project

### Terraform Deployment

1) Execute the following command $export VAGRANT_VAGRANTFILE="Vagrantfile.vbox"
2) Bring the VM up with $vagrant up
3) Connect with the VM $vagrant ssh mgmt
4) Access the terraform folder $cd terraform
5) Connect to your project (in Google Cloud use $gcloud auth login followed by $gcloud config set project <name-of-your-project>
6) Initialize Terraform $terraform init 
7) Plan the deployment $terraform plan 
8) If no errors are reported apply the changes $terraform apply  
9) If everything went rigth, the application is now deployed (check the ingress IP in the Dashport of your Cloud Provider)! Enjoy our store!

### Screenshots of the deployment steps

<img width="682" alt="Captura de ecrã 2022-11-04, às 15 16 57" src="https://user-images.githubusercontent.com/56162588/200011435-6f530a03-7cce-4774-a590-1f8af88f0ee1.png">
<img width="682" alt="Captura de ecrã 2022-11-04, às 15 17 47" src="https://user-images.githubusercontent.com/56162588/200011465-f25674a7-3798-4c2f-9e50-68e213756442.png">

<img width="969" alt="Captura de ecrã 2022-11-04, às 15 18 47" src="https://user-images.githubusercontent.com/56162588/200011586-1f2999d4-8005-4cef-b58a-b8c95853070a.png">

<img width="969" alt="Captura de ecrã 2022-11-04, às 15 19 11" src="https://user-images.githubusercontent.com/56162588/200011543-831c1a8f-4540-45a9-88fe-b864fcefa6e1.png">

<img width="969" alt="Captura de ecrã 2022-11-04, às 15 19 07" src="https://user-images.githubusercontent.com/56162588/200011553-524b229b-306f-464c-93aa-2c0dacf63ed2.png">

