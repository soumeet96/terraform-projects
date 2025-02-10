resource "aws_iam_role" "codebuild_role" {
    name = "codebuild-role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Effect = "Allow"
            Principal = {
                Service = "codebuild.amazonaws.com"
            }
            Action = "sts:AssumeRole"
        }]
    })

    tags = {
        Name = "CodeBuild Role"
    }
}

resource "aws_iam_role_policy_attachment" "codebuild_policy" {
    role = aws_iam_role.codebuild_role.name
    policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
}

resource "aws_iam_role" "codepipeline_role" {
    name = "codepipeline-role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Effect = "Allow"
            Principal = {
                Service = "codepipeline.amazonaws.com"
            }
             Action = "sts:AssumeRole"
        }]
    })

    tags = {
        Name = "CodePipeline Role"
    }
}

resource "aws_iam_role_policy_attachment" "codepipeline_policy" {
    role = aws_iam_role.codepipeline_role.name
    policy_arn = "arn:aws:iam::aws:policy/AWSCodePipelineFullAccess"
}