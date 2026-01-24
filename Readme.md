<div align="center">

# 🛍️ Trendstore

### A Modern E-Commerce Deployment on AWS EKS

[![Build Status](https://img.shields.io/badge/Build-Passing-success?style=for-the-badge&logo=jenkins)](https://jenkins.io)
[![Docker Image](https://img.shields.io/badge/Docker-Hub-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/r/sheershsinha/trendstore)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-EKS-326CE5?style=for-the-badge&logo=kubernetes)](https://kubernetes.io)
[![Terraform](https://img.shields.io/badge/Infrastructure-Terraform-7B42BC?style=for-the-badge&logo=terraform)](https://www.terraform.io)
[![AWS](https://img.shields.io/badge/Cloud-AWS-232F3E?style=for-the-badge&logo=amazon-aws)](https://aws.amazon.com)

</div>

---

## 📖 About The Project

**Trendstore** is a scalable web application deployed on **Amazon Web Services (AWS)** using **Elastic Kubernetes Service (EKS)**. This repository contains the complete Infrastructure as Code (IaC), containerization logic, and CI/CD pipeline configurations required to deploy the application reliably and efficiently.

The application is served using **Nginx** inside a Docker container, orchestrated by Kubernetes, and the underlying infrastructure is provisioned using **Terraform**.

---

## 🛠️ Technology Stack

| Category | Technology | Description |
| :--- | :--- | :--- |
| **Containerization** | ![Docker](https://img.shields.io/badge/-Docker-2496ED?style=flat&logo=docker&logoColor=white) | Container runtime for packaging the application. |
| **Orchestration** | ![Kubernetes](https://img.shields.io/badge/-Kubernetes-326CE5?style=flat&logo=kubernetes&logoColor=white) | Manages the deployment, scaling, and operations of application containers. |
| **Infrastructure** | ![Terraform](https://img.shields.io/badge/-Terraform-7B42BC?style=flat&logo=terraform&logoColor=white) | Provisions the AWS VPC, EKS Cluster, and related resources. |
| **CI/CD** | ![Jenkins](https://img.shields.io/badge/-Jenkins-D24939?style=flat&logo=jenkins&logoColor=white) | Automates the build, test, and deployment pipeline. |
| **Cloud Provider** | ![AWS](https://img.shields.io/badge/-AWS-232F3E?style=flat&logo=amazon-aws&logoColor=white) | Hosting environment (EKS, EC2, VPC). |
| **Web Server** | ![Nginx](https://img.shields.io/badge/-Nginx-009639?style=flat&logo=nginx&logoColor=white) | High-performance web server serving the static assets. |

---

## 🚀 CI/CD Pipeline

The project uses a **Jenkins** pipeline defined in `Jenkins/jenkinsfile` to automate the deployment process.

```mermaid
graph LR
    A[Git Checkout] --> B[Build Docker Image]
    B --> C[Push to DockerHub]
    C --> D[Update Kubeconfig]
    D --> E[Deploy to EKS]
```

### Pipeline Stages:

1.  **Checkout Code**: Pulls the latest code from the `main` branch.
2.  **Build Docker Image**: Builds the image `sheershsinha/trendstore:v1` using the `Dockerfile`.
3.  **Login & Push**: Logs into DockerHub using credentials and pushes the image (tagged `v1` and `latest`).
4.  **Update Kubeconfig**: Authenticates with AWS and updates `kubeconfig` to interact with the `Trendstore-eks` cluster in `us-east-2`.
5.  **Deploy to EKS**: Applies the Kubernetes manifests:
    *   `deployment.yml`: Deploys the application pods.
    *   `service.yml`: Exposes the application via a Service.

---

## ⚙️ Setup & Deployment Instructions

### 1. Prerequisites

Ensure you have the following tools installed:
*   [AWS CLI](https://aws.amazon.com/cli/) (Configured with appropriate permissions)
*   [Terraform](https://www.terraform.io/downloads)
*   [Docker](https://www.docker.com/)
*   [kubectl](https://kubernetes.io/docs/tasks/tools/)

### 2. Infrastructure Provisioning (Terraform)

Navigate to the Terraform directory to provision the AWS EKS cluster.

```bash
cd Terraform
terraform init
terraform plan
terraform apply --auto-approve
```
*This will create the VPC, Subnets, Security Groups, and the EKS Cluster.*

### 3. Application Deployment (Manual)

If you want to deploy manually without Jenkins:

**Build & Push Image:**
```bash
docker build -t your-dockerhub-user/trendstore:latest .
docker push your-dockerhub-user/trendstore:latest
```

**Deploy to Kubernetes:**
Ensure your `kubectl` is configured for the EKS cluster:
```bash
aws eks update-kubeconfig --region us-east-2 --name Trendstore-eks
```

Apply the manifests:
```bash
cd Kubernetes
kubectl apply -f deployment.yml
kubectl apply -f service.yml
```

### 4. Jenkins Configuration

To use the automated pipeline, configure Jenkins with the following credentials:
*   **Token-02**: Username/Password credential for DockerHub.
*   **AWS Credentials**: Configure AWS credentials on the Jenkins agent or use IAM roles if running on EC2.

---

## 📂 Project Structure

```
Trendstore/
├── Jenkins/
│   └── jenkinsfile       # CI/CD Pipeline definition
├── Kubernetes/
│   ├── deployment.yml    # K8s Deployment manifest
│   └── service.yml       # K8s Service manifest
├── Terraform/
│   ├── main.tf           # Main Terraform configuration
│   ├── variables.tf      # Variable definitions
│   └── ...
├── dist/                 # Static application assets
├── dockerfile            # Docker image definition
└── Readme.md             # Project documentation
```

---

<div align="center">

Made with ❤️ by **Sheersh Sinha**

</div>
