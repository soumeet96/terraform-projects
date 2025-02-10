resource "aws_codepipeline" "pipeline" {
    name = "cicd-pipeline"
    role_arn = aws_iam_role.codepipeline_role.arn

    artifact_store {
    location = aws_s3_bucket.website_bucket.id
    type = "S3"
    }

    stage {
        name = "Source"
        action {
            name = "Source"
            category = "Source"
            owner = "AWS"
            provider = "CodeCommit"
            version = "1"
            output_artifacts = ["source_output"]
            configuration = {
                RepositoryName = aws_codecommit_repository.source_repo.repository_name
                BranchName = "main"
            }
        }
    }

    stage {
        name = "Build"
        action {
            name = "Build"
            category = "Build"
            owner = "AWS"
            provider = "CodeBuild"
            version = "1"
            input_artifacts = ["source_output"]
            output_artifacts = ["build_output"]
            configuration = {
                ProjectName = aws_codebuild_project.build_project.name
            }
        }
    }

    stage {
        name = "Deploy"
        action {
            name = "Deploy"
            category = "Deploy"
            owner = "AWS"
            provider = "S3"
            version = "1"
            input_artifacts = ["build_output"]
            configuration = {
                BucketName = aws_s3_bucket.website_bucket.bucket
                Extract = "true"
            }
        }
    }
    tags = {
        Name = "CI/CD Pipeline"
    }
}