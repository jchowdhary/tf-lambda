data "aws_region" "current" {
}

data "aws_caller_identity" "current" {
}

locals {
  src_bucket_name = "verizondemos3_src_bucket"
  dest_bucket_name = "verizondemos3_dest_bucket"
}

# Source S3 bucket
resource "aws_s3_bucket" "verizondemos3srcbucket" {
  bucket = "verizondemos3srcbucket"
  acl    = "public-read-write"

  tags = {
    Name        = "source_bucket"
    Environment = "Dev"
  }

  }
  # lifecycle_rule {
  #   id      = "rule1"
  #   prefix  = "tmp/"
  #   enabled = true

  #   expiration {
  #     days  = 30
  #   }
    # transition {
    #   days          = 15
    #   storage_class = "STANDARD_IA"
#     # }
#   }
# }

# Destination S3 bucket
resource "aws_s3_bucket" "verizondemos3destbucket" {
  bucket = "verizondemos3destbucket"
  acl    = "public-read-write"

  tags = {
    Name        = "destination_bucket"
    Environment = "Dev"
  }

  # versioning {
  #   enabled = true

  # }
}

# Adding an Lambda trigger for S3 object creation event in src bucket
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.verizondemos3srcbucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.lambda_function.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "*"
    filter_suffix       = ".txt"
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}




###########
# output of lambda arn
###########
output "arn" {

value = "${aws_lambda_function.lambda_function.arn}"

}