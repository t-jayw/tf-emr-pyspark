terraform {
  backend "s3" {
    encrypt = true
    bucket  = "tjw-terraform"
    key     = "terraform-emr-pyspark.tfstate"
    region  = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
  profile = "tylerw"
}

