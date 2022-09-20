module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "4.1.0"
  domain_name = "obatos.de"  #trimsuffix(data.aws_route53_zone.mydomain.name, ".")

  zone_id      = data.aws_route53_zone.mydomain.id

  subject_alternative_names = [
    "*.obatos.de"

    
  ]

  tags =  local.common_tags
  }

# Output ACM Certificate ARN
output "acm_certificate_arn" {
  description = "ACM Certificate ARN"
  value = module.acm.acm_certificate_arn
}


