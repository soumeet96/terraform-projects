# Deploy a High Availability (HA) Web Application on AWS Using Terraform

## Overview
This project demonstrates how to deploy a highly available web application on AWS using Terraform. The infrastructure includes:
- **Virtual Private Cloud (VPC)** for network isolation
- **Public & Private Subnets** in multiple Availability Zones
- **Internet Gateway & Route Tables** for internet access
- **EC2 Instances** for web servers
- **Application Load Balancer (ALB)** for traffic distribution
- **Auto Scaling Group (ASG)** for fault tolerance & scalability
- **Security Groups** for controlled access

## Prerequisites
Before running this Terraform configuration, ensure you have:
- An **AWS account**
- **Terraform** installed ([Download Terraform](https://www.terraform.io/downloads))
- **AWS CLI** installed and configured (`aws configure`)
- An existing **SSH Key Pair** in AWS

## Setup Instructions

### Step 1: Clone the Repository
```sh
git clone https://github.com/soumeet96/terraform-projects
cd Project-1
```

### Step 2: Initialize Terraform
```sh
terraform init
```

### Step 3: Review and Customize Configuration
- Modify `variables.tf` to adjust settings such as region, instance type, or CIDR blocks.
- Ensure `key_name` in `autoscaling.tf` matches your AWS key pair.

### Step 4: Deploy the Infrastructure
```sh
terraform apply -auto-approve
```
Wait for Terraform to create the resources (~5 minutes).

### Step 5: Get Load Balancer DNS
```sh
echo "http://$(terraform output alb_dns_name)"
```
Copy and paste the output URL into your browser to access the web application.

## Cleanup
To delete all AWS resources created by Terraform, run:
```sh
terraform destroy -auto-approve
```

## File Structure
```
Project-1/
├── main.tf          # AWS provider & main configuration
├── vpc.tf           # VPC, subnets, and networking resources
├── sg.tf            # Security groups
├── ec2.tf           # EC2 instances
├── alb.tf           # Application Load Balancer
├── autoscaling.tf   # Auto Scaling configuration
├── README.md        # Project documentation
```

## Resources Created
- **VPC**: `10.0.0.0/16`
- **Subnets**: Public & Private (Multi-AZ)
- **EC2 Instances**: Auto-scaled web servers
- **ALB**: Load balances HTTP traffic
- **Auto Scaling Group**: Ensures high availability
- **Security Groups**: Restrict access

## Troubleshooting
### Issue: Load Balancer Requires Two Subnets
**Error Message:**
```
Error: creating ELBv2 application Load Balancer: ValidationError: At least two subnets in two different Availability Zones must be specified
```
**Fix:** Ensure that at least two subnets are defined in different availability zones.

### Issue: Auto Scaling Launch Configuration Not Supported
**Error Message:**
```
Error: creating Auto Scaling Launch Configuration: UnsupportedOperation: The Launch Configuration creation operation is not available in your account.
```
**Fix:** Replace `aws_launch_configuration` with `aws_launch_template` as AWS recommends using launch templates.

### Issue: Invalid AMI ID
**Error Message:**
```
Error: creating EC2 Instance: InvalidAMIID.NotFound: The image id '[ami-0c55b159cbfafe1f0]' does not exist
```
**Fix:** Find a valid Amazon Linux 2 AMI using:
```sh
aws ec2 describe-images --owners amazon --filters "Name=name,Values=amzn2-ami-hvm-*" --query "Images | sort_by(@, &CreationDate) | [-1].ImageId"
```
Update the AMI ID in `autoscaling.tf`.

### Issue: Subnet CIDR Conflict
**Error Message:**
```
Error: creating EC2 Subnet: The CIDR '10.0.1.0/24' conflicts with another subnet
```
**Fix:** Ensure each subnet has a unique CIDR block.

### Issue: Incorrect Attribute Value Type
**Error Message:**
```
Error: Incorrect attribute value type
```
**Fix:** Ensure that `subnet_id` is a single string and not a list when associating a subnet with a route table.

### Issue: Missing Resource Reference
**Error Message:**
```
Error: Reference to undeclared resource
```
**Fix:** Ensure that all referenced resources exist and are correctly named in Terraform files.

---
Created by **Soumeet Acharya** 🚀


