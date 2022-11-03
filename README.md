## Deploying the application on GCP				##  This Directory contains the folders and files for the GCP Kubernetes

![online-Boutique screenshot]()				

### Online-boutique				

#### Microservices accessed by the client				
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

#### Maintenance				
- grafana				
- prometheus				
- istiod				
- redis-leader				
- redis-follower				

## Description				

This project was done using Terraform and Kubernetes, inspired by the Google Cloud Platform microservices-demo project (https://github.com/GoogleCloudPlatform/microservices-demo)				

First, we build the Docker images using the GCP-demo Dockerfile and upload them to a dockerhub.io repository[https://hub.docker.com/r/ricardojss/agisit-team29/tags]. We choose to use Terraform as an Infrastructure-as-Code tool to deploy our Kubernetes cluster to a cloud provider.				
To do so, we created several Terraform files including the k8s-pods.tf that describes the Kubernetes pods that are used the Dockerimages to specify the microservices. It also includes information about the ports, the environments variables and the number of replicas (we choose 3).				
We also created the k8s-services.tf to defines the services for each microservices and the gcp-gke-cluster.tf file to define the cluster where the Kubernetes cluster will be deployed (GCP).				

## Deploy the Online-Boutique to a generic cloud				

### In Google Cloud Platform				
#### Install gcloud cli				
- https://cloud.google.com/sdk/docs/install-sdk				

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
