resource "aws_s3_bucket" "website_bucket" {
    bucket = "cicd-website-bucket"
    acl = "public-read"

    website {
        index_document = "index.html"
    }

    tags = {
        Name = "CICD Website Bucket"
    }
}

resource "aws_s3_bucket_policy" "website_bucket_policy" {
    bucket = aws_s3_bucket.website_bucket.id

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
        Effect = "Allow"
        Principal = "*"
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.website_bucket.arn}/*"
        }]
    })
}