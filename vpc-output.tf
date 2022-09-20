output "vpc_id" {
  description = "The ID of VPC"
  value = module.vpc.vpc_id
}

#VPC Private Subnets
output "private_subnets" {
  description = "List IDs of private subnets"
  value = module.vpc.private_subnets
}

#VPC Public Subnets
output "public_subnets" {
  description = "List IDs of public subnets"
  value = module.vpc.public_subnets
}