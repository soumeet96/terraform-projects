# Automating CI/CD Pipeline Deployment on AWS

## Overview
This project automates the deployment of a complete CI/CD pipeline on AWS using Terraform. The pipeline integrates multiple AWS services to enable seamless continuous integration and deployment.

## Project Structure
- **`main.tf`** - Defines the AWS provider.
- **`s3.tf`** - Configures an S3 bucket for hosting the static website.
- **`codecommit.tf`** - Sets up a CodeCommit repository for source control.
- **`codebuild.tf`** - Defines the CodeBuild project for application builds.
- **`iam.tf`** - Configures IAM roles and permissions for CodeBuild and CodePipeline.
- **`codepipeline.tf`** - Establishes the CodePipeline for automation.
- **`outputs.tf`** - Outputs key information after deployment.

## Implementation Steps
### 1. Set Up Terraform
- Install Terraform on your local machine.
- Create a project directory (e.g., `terraform-cicd-pipeline`).
- Initialize Terraform using `terraform init`.

### 2. Define AWS Infrastructure
- Configure the AWS provider for deployment in a chosen region.
- Create an S3 bucket to host the static website.
- Set up a CodeCommit repository to store source code.

### 3. Configure IAM Roles and Permissions
- Create IAM roles for CodeBuild and CodePipeline.
- Attach necessary policies to enable secure access to AWS services.

### 4. Set Up CI/CD Pipeline
- Define a CodeBuild project to build and package the application.
- Create a CodePipeline with stages for source retrieval, build, and deployment.
- Store pipeline artifacts in an S3 bucket.

### 5. Apply Terraform Configuration
- Validate the configuration using `terraform validate`.
- Preview the planned changes with `terraform plan`.
- Deploy the infrastructure using `terraform apply`.
- Confirm the deployment when prompted.

## Outcome
After successful deployment, the CI/CD pipeline consists of:
- An S3 bucket hosting a static website.
- A CodeCommit repository for source code management.
- A CodeBuild project for automated application builds.
- A CodePipeline managing the CI/CD workflow.

## Troubleshooting & Issues Faced
### 1. **IAM Role Permission Errors**
- Issue: CodePipeline failing due to missing IAM permissions.
- **Solution**: Ensured correct IAM policy attachments for CodePipeline and CodeBuild roles.

### 2. **CodeCommit Authentication Issues**
- Problem accessing the CodeCommit repository from local machine.
- **Solution**: Configured AWS CLI credentials and HTTPS Git credentials.

### 3. **S3 Bucket Public Access Restrictions**
- Website not accessible after deployment.
- **Solution**: Verified bucket policy settings and ensured public read access.

## How to Use This Project
1. Clone the repository.
2. Modify the Terraform configuration as needed.
3. Run `terraform init`, `terraform plan`, and `terraform apply` to deploy.
4. Use the output values to verify deployed resources.

## Clean Up
To remove all resources created by Terraform, run:
```sh
terraform destroy
```

## Author
Project developed as part of an AWS infrastructure automation exercise using Terraform.

---

Created by **Soumeet Acharya** 🚀