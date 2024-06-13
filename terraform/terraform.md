# Clone this Git project, it contains Terraform files
```
git clone https://github.com/TPIsoftware-digirunner/digirunner.git
cd digirunner/terraform
```
### Set up your `REGION` and `LOCATION`, these two environment variables will be referenced within the Terraform configuration

If necessary, you can modify it.
```
# example:
export REGION="asia-east1"
export LOCATION="asia-east1-a"
```
### Create service account for terraform
```
gcloud iam service-accounts create tf-digi --display-name "tf-digi"
```
### Generate service account keys that will be utilized by Terraform for the purposes of authentication and creating infrastructure resources
```
gcloud iam service-accounts keys create ~/tf-digi.json --iam-account=tf-digi@$PROJECT_ID.iam.gserviceaccount.com
```
---
### Grant IAM roles
```
# VM-instance, GKE
gcloud projects add-iam-policy-binding $PROJECT_ID --member "serviceAccount:tf-digi@$PROJECT_ID.iam.gserviceaccount.com" --role "roles/compute.instanceAdmin"
# Kubernetes Engine Cluster Admin 
gcloud projects add-iam-policy-binding $PROJECT_ID --member "serviceAccount:tf-digi@$PROJECT_ID.iam.gserviceaccount.com" --role "roles/container.clusterAdmin"
# Cloud Storage Buckets
gcloud projects add-iam-policy-binding $PROJECT_ID --member "serviceAccount:tf-digi@$PROJECT_ID.iam.gserviceaccount.com" --role "roles/storage.admin"
# VPC, subnet
gcloud projects add-iam-policy-binding $PROJECT_ID --member "serviceAccount:tf-digi@$PROJECT_ID.iam.gserviceaccount.com" --role "roles/compute.networkAdmin"
# Global IP
gcloud projects add-iam-policy-binding $PROJECT_ID --member "serviceAccount:tf-digi@$PROJECT_ID.iam.gserviceaccount.com" --role "roles/compute.publicIpAdmin"
# Terraform query enable API
gcloud projects add-iam-policy-binding $PROJECT_ID --member "serviceAccount:tf-digi@$PROJECT_ID.iam.gserviceaccount.com" --role "roles/serviceusage.serviceUsageConsumer"
# Grant digiRunner Service Account using default compute Service Account
gcloud projects add-iam-policy-binding $PROJECT_ID --member "serviceAccount:tf-digi@$PROJECT_ID.iam.gserviceaccount.com" --role "roles/iam.serviceAccountUser"
# Kubernetes Engine Admin, Create k8s resource
gcloud projects add-iam-policy-binding $PROJECT_ID --member "serviceAccount:tf-digi@$PROJECT_ID.iam.gserviceaccount.com" --role "roles/container.admin"
# Container Threat Detection Service Agent, store key to GKE secret
gcloud projects add-iam-policy-binding $PROJECT_ID --member "serviceAccount:tf-digi@$PROJECT_ID.iam.gserviceaccount.com" --role "roles/containerthreatdetection.serviceAgent"
# gcloud sql instances patch
gcloud projects add-iam-policy-binding $PROJECT_ID --member "serviceAccount:tf-digi@$PROJECT_ID.iam.gserviceaccount.com" --role "roles/cloudsql.admin"
# Create Service Accounts and CloudSQL Service Accounts
gcloud projects add-iam-policy-binding $PROJECT_ID --member "serviceAccount:tf-digi@$PROJECT_ID.iam.gserviceaccount.com" --role "roles/iam.serviceAccountCreator"
# Security Reviewer 
gcloud projects add-iam-policy-binding $PROJECT_ID --member "serviceAccount:tf-digi@$PROJECT_ID.iam.gserviceaccount.com" --role "roles/iam.securityReviewer"
```
### Create a Cloud Storage Buckets
```
# Bucket name must be globally unique.
export TIME=`date +%s`
gsutil mb -p $PROJECT_ID -c STANDARD -l asia-east1 gs://tf-state-digi-$TIME
```
### Terraform state bucket
```
envsubst < manifest_backend > backend.tf
```

### Set up terraform variables to tfvars.
```
envsubst < manifest_terraform > terraform.tfvars
```

### Set up database password to manifest.
```
envsubst < manifest_postgresql > postgresql.tf
```
### To set up your Application resources, run the following command:
```
terraform init
terraform apply -auto-approve
```
