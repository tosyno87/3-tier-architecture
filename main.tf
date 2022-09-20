# Terraform Module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"
  # version = ~>2.78
#VPC Basic
name = "vpc-dev"
cidr =  "10.0.0.0/16"
azs             = ["us-east-2a", "us-east-2b"]
private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnets  = ["10.0.12.0/24", "10.0.30.0/24"]

database_subnets = ["10.0.34.0/24", "10.0.40.0/24"]
#NAt Gateway for outbound communication
enable_nat_gateway = true
single_nat_gateway = true

#VPC DNS Parameters
enable_dns_hostnames  = true
enable_dns_support = true
public_subnet_tags = {
    Name = "Public-subs"
}
private_subnet_tags = {
    Name = "Private-subs"
}
database_subnet_tags = {
    Name = "Database-subnets"
}
tags = {
    Owner = "Tosin"
    Environment = "dev"
}
vpc_tags = {
    Name = "vpc-dev"
}
#create_database_subnet_group = true 
#create_database_subnet_route_table = true 


}