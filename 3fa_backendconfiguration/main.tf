#not complete

provider "aws" {
  region = "us-east-2"
  shared_credentials_files = ["~/.aws/credentials"]
}


/*
First create it with this block commented 
then uncomment and run 
	terraform init 
	terraform apply 

terraform {
  backend "s3" {
    bucket         = "vilasterrastate1"
    key            = "vilas/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "vilas-terraform-lock-table"
	encrypt			= true                                             
  }
}

when destroying also 
comment dynamodb and s3 destroy and get the lock removed state file back on local disk
then destroy s3 and dynamdb 

*/

resource "aws_s3_bucket" "terraform_state" {
  bucket = "vilasterrastate1"
 
  # Prevent accidental deletion of this S3 bucket
  /*lifecycle {
    prevent_destroy = true
  }*/
}

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "vilas-terraform-lock-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}