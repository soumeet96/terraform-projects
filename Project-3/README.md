# Automating Kubernetes Cluster Deployment on AWS Using Terraform

## Overview
This project focuses on automating the deployment of an **Amazon Elastic Kubernetes Service (EKS)** cluster using **Terraform**. It sets up a managed Kubernetes control plane, worker nodes, and networking infrastructure to host containerized applications.

## Project Structure
- **`main.tf`** - Defines the AWS provider.
- **`vpc.tf`** - Creates the Virtual Private Cloud (VPC) and subnets.
- **`iam.tf`** - Configures IAM roles and policies for EKS.
- **`eks.tf`** - Deploys the EKS cluster and worker nodes.
- **`outputs.tf`** - Outputs essential information after deployment.

## Implementation Steps
### 1. Set Up Terraform
- Install Terraform on your local machine.
- Create a project directory (e.g., `terraform-eks-cluster`).
- Initialize Terraform using `terraform init`.

### 2. Configure the AWS Provider
- Define the AWS region and credentials.
- Ensure proper authentication with AWS CLI.

### 3. Create a VPC
- Define a **VPC** with public and private subnets.
- Attach an **Internet Gateway** and configure routing.

### 4. Deploy an EKS Cluster
- Use the **Terraform AWS EKS module** to create the cluster.
- Define worker node groups with appropriate instance types.
- Attach necessary IAM roles for Kubernetes.

### 5. Apply Terraform Configuration
- Validate the configuration using `terraform validate`.
- Preview the infrastructure changes using `terraform plan`.
- Deploy the infrastructure using `terraform apply`.

### 6. Configure `kubectl`
- Update your **kubeconfig** file using AWS CLI.
- Verify the cluster connection with `kubectl get nodes`.

### 7. Deploy a Sample Application
- Define a Kubernetes **Deployment** and **Service** YAML file.
- Apply the deployment using `kubectl apply`.
- Expose the application using a **LoadBalancer Service**.

## Troubleshooting & Issues Faced
### 1. **Unsupported Argument Errors in Terraform**
- **Error:** `Unsupported argument: "subnets"`
- **Solution:** Used `subnet_ids` instead of `subnets` in the EKS module.

### 2. **EKS Node Group Creation Taking Too Long**
- **Issue:** Node group stuck in `Creating` state for more than 15 minutes.
- **Solution:** Verified IAM permissions, subnets, and proper tagging.

### 3. **Node Group Created but No Nodes Visible**
- **Issue:** EC2 instances launched, but `kubectl get nodes` showed nothing.
- **Solution:** Checked if the IAM role for the nodes was correctly associated and ensured worker nodes joined the cluster.

### 4. **IAM Role Not Associated with Worker Nodes**
- **Issue:** No IAM role was attached to the worker node group.
- **Solution:** Explicitly defined `iam_role_arn` in Terraform for the worker nodes.

### 5. **Cluster Access Issues with `kubectl`**
- **Error:** `Your current IAM principal doesn’t have access to Kubernetes objects on this cluster.`
- **Solution:**
  - Added the IAM role to the **aws-auth ConfigMap**.
  - Updated `kubeconfig` using `aws eks update-kubeconfig`.
  - Ensured the IAM user had necessary permissions.

## How to Use This Project
1. Clone the repository.
2. Modify Terraform configurations as needed.
3. Run `terraform init`, `terraform plan`, and `terraform apply` to deploy.
4. Update your `kubectl` configuration to access the cluster.
5. Deploy applications to Kubernetes.

## Clean Up
To remove all resources created by Terraform, run:
```sh
terraform destroy
```

## Author
Project developed as part of AWS infrastructure automation using Terraform. 🚀

---

Created by **Soumeet Acharya** 🚀