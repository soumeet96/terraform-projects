resource "aws_codecommit_repository" "source_repo" {
  repository_name = "cicd-demo-repo-soumeet"
  description     = "CodeCommit repository for CI/CD demo"
  tags = {
    Name = "CI/CD Demo Repo"
  }
}

resource "aws_codebuild_project" "build_project" {
  name         = "cicd-build-project"
  service_role = aws_iam_role.codebuild_role.arn
  source {
    type     = "CODECOMMIT"
    location = aws_codecommit_repository.source_repo.clone_url_http
  }
  artifacts {
    type      = "S3"
    location  = aws_s3_bucket.website_bucket.id
    packaging = "ZIP"
  }
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:5.0"
    type         = "LINUX_CONTAINER"
    environment_variable {
      name  = "S3_BUCKET"
      value = aws_s3_bucket.website_bucket.bucket
    }
  }

  depends_on = [aws_codecommit_repository.source_repo]

  tags = {
    Name = "Build Project"
  }
}