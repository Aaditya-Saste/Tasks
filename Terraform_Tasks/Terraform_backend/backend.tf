terraform {
  backend "s3" {
    bucket = "aaditya-s3-new-xyz"
    key    = "aaditya/terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terraform-lock"
    
    access_key = "AKIATA56LGDNQDSZVT2E"
    secret_key = "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"
  }
}
