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
- **Issue**: CodePipeline was failing during execution due to insufficient IAM permissions for the roles associated with CodePipeline and CodeBuild.
- **Solution**: The issue was resolved by ensuring that the IAM roles for **CodePipeline** and **CodeBuild** had the correct policies attached:
  - For **CodeBuild**, I attached the `AWSCodeBuildDeveloperAccess` policy.
  - For **CodePipeline**, I attached the `AWSCodePipelineFullAccess` policy.
  - Additionally, I confirmed that the **CodePipeline Role** had permission to access the CodeCommit repository and the S3 bucket.

### 2. **CodeCommit Authentication Issues**
- **Issue**: There were problems accessing the **CodeCommit** repository from the local machine using HTTPS.
- **Solution**: 
  - The problem was resolved by ensuring that the **AWS CLI credentials** were properly configured. I ran `aws configure` to set up the appropriate credentials.
  - For accessing the CodeCommit repository via HTTPS, I configured **Git credentials** for AWS CodeCommit. This required generating credentials from the **IAM user settings** in the AWS console and using them with Git.
  - Once these were properly configured, I was able to push the initial code to the repository without any issues.

### 3. **S3 Bucket Public Access Restrictions**
- **Issue**: After deploying the website, the S3 bucket's content was not publicly accessible. The static website was not loading.
- **Solution**:
  - The issue was related to the **S3 bucket policy**. Initially, I hadn't set the **S3 bucket** to allow **public read access**.
  - I updated the **S3 bucket policy** to ensure that the content could be publicly accessible. The updated policy allowed for `GetObject` actions on all objects within the bucket, ensuring the website files could be accessed via their public URL.

### 4. **CodeCommit Repository Creation Errors**
- **Issue**: During the deployment, I encountered an error stating that the **CodeCommit repository** could not be created due to recent changes in AWS's policy regarding new repositories. The error message indicated the need for an existing repository in the account or an allowlisting request.
- **Solution**:
  - I discovered that as of June 6, 2024, AWS CodeCommit has stopped allowing the creation of new repositories unless there are existing repositories within the account. To address this:
    - I either needed to submit an **allowlisting request** to AWS support for my account (to create new repositories) or use a different service for version control (e.g., **GitHub**, **GitLab**).
    - In my case, I had to update my process to include an already existing CodeCommit repository or use another Git provider as an alternative for source control.

### 5. **Missing or Incorrect Environment Variables in CodeBuild**
- **Issue**: The **CodeBuild** project failed because the environment variables for **S3_BUCKET** were not being passed correctly.
- **Solution**: 
  - After reviewing the **CodeBuild configuration**, I realized I was using an incorrect attribute for environment variables. I replaced `environment_variables` with `environment_variable` (singular), which resolved the issue. The correct configuration for environment variables should look like this:
    ```hcl
    environment {
        compute_type = "BUILD_GENERAL1_SMALL"
        image = "aws/codebuild/standard:5.0"
        type = "LINUX_CONTAINER"
        environment_variable {
            name  = "S3_BUCKET"
            value = aws_s3_bucket.website_bucket.bucket
        }
    }
    ```

### 6. **CodePipeline FullAccess Policy Missing**
- **Issue**: CodePipeline was failing to execute because the **CodePipeline** IAM role did not have the correct permissions for managing the pipeline.
- **Solution**: The issue was resolved by ensuring that the **CodePipeline** role had the correct full access policy attached. Specifically, the `AWSCodePipeline_FullAccess` policy needed to be attached to the **CodePipeline** IAM role.
  - I made sure the following policy was correctly attached to the IAM role associated with CodePipeline:
    ```hcl
    resource "aws_iam_role_policy_attachment" "codepipeline_policy" {
      role       = aws_iam_role.codepipeline_role.name
      policy_arn = "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess"
    }
    ```

## **Recent Changes in AWS CodeCommit**  
### Important Update:
AWS CodeCommit has made a significant policy change affecting new customers:
- As of **June 6, 2024**, AWS CodeCommit stopped onboarding new customers. This means that **new AWS accounts** or **organizations** cannot create new repositories in AWS CodeCommit unless there are existing repositories within the account.
- If you need to create a new repository in a fresh AWS account, you must submit an **allowlisting request** to AWS Support, explaining why you need access to CodeCommit. 
- This change does not affect existing customers or workloads, so if you already have a CodeCommit repository, you can continue using the service as usual.

### **Alternative Solutions**:
If you are unable to create a CodeCommit repository, AWS recommends using **Amazon CodeCatalyst**, **GitHub**, **GitLab**, or other third-party Git repository solutions. These can be easily integrated into the CI/CD pipeline as a source stage for the pipeline.

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