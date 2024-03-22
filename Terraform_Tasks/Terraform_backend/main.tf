provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIATA56LGDNQDSZVT2E"
  secret_key = "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"
}

resource "aws_instance" "this_instance" {
  instance_type = "t2.micro"
  ami           = "ami-0ba259e664698cbfc"
  subnet_id     = "subnet-04c81c60bb1422da5"
  tags = {
    Name = "backend_int"
  }
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "aaditya-s3-new-xyz"
}

resource "aws_dynamodb_table" "terraform_lock" {
  name           = "terraform-lock"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
