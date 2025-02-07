# Deploying a Secure Multi-Tier Web Application on AWS

## Overview
This project demonstrates how to deploy a secure multi-tier web application architecture on AWS using Terraform. The architecture consists of three tiers:

- **Web Tier**: Public-facing layer to serve client requests.
- **Application Tier**: Internal layer for business logic processing.
- **Database Tier**: Secure private layer to store data.
- **Bastion Host**: Provides secure SSH access to private resources.

## Project Structure
- **`main.tf`** - Defines the AWS provider.
- **`vpc.tf`** - Creates the Virtual Private Cloud (VPC) and subnets.
- **`security_groups.tf`** - Defines security groups for controlled access between tiers.
- **`instances.tf`** - Deploys EC2 instances for the web, application, database tiers, and bastion host.
- **`outputs.tf`** - Outputs essential information after deployment.

## Implementation Steps
### 1. Set Up Terraform
- Install Terraform on your local machine.
- Create a project directory (e.g., `terraform-multi-tier-app`).
- Initialize Terraform using `terraform init`.

### 2. Define AWS Infrastructure
- Configure the AWS provider to deploy resources in a specific region.
- Create a Virtual Private Cloud (VPC) for network isolation.
- Define public and private subnets for different application tiers.
- Add an Internet Gateway to allow public access to the web tier.
- Set up routing to ensure proper communication between tiers.

### 3. Configure Security Groups
- Create security groups for the web, application, and database tiers.
- Allow HTTP access to the web tier from anywhere.
- Restrict access to the application tier to only allow traffic from the web tier.
- Secure the database tier by only allowing traffic from the application tier.
- Set up a bastion host security group for SSH access.

### 4. Deploy EC2 Instances
- Launch instances for the web, application, and database tiers.
- Deploy a bastion host to provide secure access to private resources.

### 5. Apply Terraform Configuration
- Validate the configuration using `terraform validate`.
- Preview the planned changes with `terraform plan`.
- Deploy the infrastructure using `terraform apply`.
- Confirm the deployment when prompted.

## Outcome
After successful deployment, the architecture consists of:
- A VPC with isolated public and private subnets.
- A web tier accessible via the public subnet.
- Secure communication between the web, application, and database tiers.
- A bastion host for controlled SSH access to private resources.

## Troubleshooting & Issues Faced
### 1. **Invalid Security Group Parameter**
- Error: `InvalidParameterCombination: The parameter groupName cannot be used with the parameter subnet`
- **Solution**: Replaced `security_groups` with `vpc_security_group_ids` in EC2 instance configurations.

### 2. **Incorrect Resource References**
- Issue with referencing security group names instead of IDs.
- **Solution**: Used `aws_security_group.<resource>.id` instead of `.name`.

### 3. **Subnet and Availability Zone Mismatch**
- Instances failing to launch due to incorrect subnet definitions.
- **Solution**: Ensured subnets were correctly mapped to availability zones.

### 4. **Public Access Issues**
- Web tier not accessible from the internet.
- **Solution**: Verified security group inbound rules and ensured correct internet gateway and routing configurations.

## How to Use This Project
1. Clone the repository.
2. Modify the Terraform configuration as needed.
3. Run `terraform init`, `terraform plan`, and `terraform apply` to deploy.
4. Use the output values to access deployed resources.

## Clean Up
To remove all resources created by Terraform, run:
```sh
terraform destroy
```

## Author
Project developed as part of an AWS infrastructure automation exercise using Terraform.

---

Created by **Soumeet Acharya** 🚀