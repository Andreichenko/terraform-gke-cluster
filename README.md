# GKE Cluster Infrastructure Deployment

![Terraform Version](https://img.shields.io/badge/Terraform-%3E%3D%201.0.0-844FBA?logo=terraform)
![GCP Provider](https://img.shields.io/badge/GCP%20Provider-%3E%3D%204.0.0-4285F4?logo=google-cloud)
![CI/CD Validation](https://img.shields.io/github/actions/workflow/status/Andreichenko/terraform-gke-cluster/validate.yml?branch=master&label=CI%2FCD)

This repository contains the root Terraform configuration to deploy a private, highly-scalable, and secure **Google Kubernetes Engine (GKE)** cluster in GCP using infrastructure submodules from `module-tf-gcp-vpc`.

---

## 📐 GKE Architecture & Network Topology

The diagram below shows the infrastructure topology and GKE node pool configuration deployed by this project:

```mermaid
graph TD
    subgraph GCP_Cloud ["🌐 Google Cloud Platform"]
        subgraph VPC ["🌐 VPC Network: 'kube'"]
            subgraph Subnet ["🔒 Subnetwork: 'kube-subnet'"]
                NodeRange["Primary range (Nodes): 10.240.0.0/16"]
                SecondaryPods["Secondary range (Pods): 10.241.0.0/16"]
                SecondarySvcs["Secondary range (Services): 10.242.0.0/16"]
            end
        end

        subgraph GKE_Cluster_Plane ["☸️ GKE Control Plane (Private)"]
            MasterAPI["API Server (Latest Stable Version)"]
        end

        subgraph Node_Pool ["📦 GKE Node Pool (e2-medium)"]
            Node1["Worker Node 1"]
            Node2["Worker Node 2"]
            Node3["Worker Node 3 (Autoscaling: 1 to 3)"]
        end
    end

    VPC_Source["module.network"] -->|1. Provision VPC & Subnets| VPC
    Cluster_Source["module.cluster"] -->|2. Create GKE Control Plane| GKE_Cluster_Plane
    Pool_Source["module.node_pool"] -->|3. Bind Node Pool to Cluster| Node_Pool
    
    MasterAPI -->|"Manage & Schedule"| Node_Pool
    Node_Pool -->|Deploy in| Subnet
```

---

## 📂 Repository Structure

* **[cluster.tf](file://cluster.tf)**: Composes submodules to build the network, private cluster control plane, and autoscaling GKE Node Pool. It dynamically queries the Google API to retrieve the latest stable Kubernetes version.
* **[provider.tf](file://provider.tf)**: Google provider setup. Reads target project and region dynamically.
* **[variables.tf](file://variables.tf)**: Defines configurations variables (e.g. region).
* **[versions.tf](file://versions.tf)**: Enforces required Terraform version (`>= 1.0`) and Google Cloud provider (`>= 4.0.0`).

---

## 🚀 How to Run & Deploy

### 1. Setup GCP Authentication
Instead of hardcoding service account JSON keys (anti-pattern), authenticate using Google Application Default Credentials (ADC):
```sh
gcloud auth application-default login
```
Set your current GCP project:
```sh
gcloud config set project YOUR_PROJECT_ID
```

### 2. Configure project variables
Create a `terraform.tfvars` file (do not commit it!) or pass variables inline:
```sh
# Modify project inside provider.tf or use env variables
export TF_VAR_region_common="us-central1"
```

### 3. Initialize and Deploy
Initialize Terraform:
```sh
terraform init
```
Generate and review deployment plan:
```sh
terraform plan
```
Apply and provision the EKS cluster:
```sh
terraform apply
```

### 4. Connect to GKE Cluster
Once the cluster is successfully provisioned, configure local `kubectl` access:
```sh
gcloud container clusters get-credentials gke-cluster --region us-central1 --project YOUR_PROJECT_ID
```
Verify the GKE nodes are ready:
```sh
kubectl get nodes
```

---

## 🛡️ CI/CD Validation
This repository has an active GitHub Actions workflow configured in `.github/workflows/validate.yml`. Upon every pull request or push to the `master` branch, it automatically initializes and validates the configuration of all GCP submodules using Terraform version `1.5.7` to ensure syntax compliance.
