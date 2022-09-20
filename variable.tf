variable "private_instance_count" {
  description = "Number of instances to provision."
  type        = number
  default     = 2
}

# Business Division
variable "business_divsion" {
  description = "Business Division in the large organization this Infrastructure belongs"
  type = string
  default = "sap"
}