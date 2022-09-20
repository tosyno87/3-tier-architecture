variable "aws_region" {
  description = "Region in which AWS resources are to be created "
  type = string
  default = "us-east-2"
}

#Environment variable
variable "Environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = "dev"
}

#Business Division
variable "business_division" {
  description = "Business Divsion in the large org"
  type = string
  default = "SAP"
}
