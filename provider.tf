terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  null = {
    source = "hashicorp/null"
    version = "3.1.1"
    }    


  }

}
# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "obatos"
    key    = "path/to/my/key"
    region = "us-east-2"
    #dynamodb_table = "terraform_state"
  }
}
