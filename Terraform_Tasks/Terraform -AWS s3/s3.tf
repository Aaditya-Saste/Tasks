provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIATA56LGDN3TWAQ4PS"
  secret_key = "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"
}

# =================================
variable "bucket-name" {
  default = "aaditya-s3-bucket-2392001"
}
#================================

resource "aws_s3_bucket" "create_s3_bucket" {

  bucket = var.bucket-name

  website {
    index_document = "index.html"
  }

  lifecycle_rule {
    id      = "archive"
    enabled = true
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }

  }

  versioning {
    enabled = true
  }

  tags = {
    Enviroment : "QA"
  }
}

resource "aws_s3_bucket_metric" "enable-metrics-bucket" {
  bucket = var.bucket-name
  name   = "EntireBucket"
}

resource "aws_s3_object" "my_object" {
  bucket  = var.bucket-name
  key     = "index.html"
  content = <<EOF
  This is the content of the sample file.
  EOF

  content_type = "text/html"
}

output "website_endpoint" {
  value = aws_s3_bucket.create_s3_bucket.website_endpoint
}

resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.create_s3_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false 
  restrict_public_buckets = false
}