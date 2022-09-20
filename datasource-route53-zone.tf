# Get DNS information from AWS Route53
data "aws_route53_zone" "mydomain" {
  name = "obatos.de"
}
#output

output "mydomain_zoneid" {
 description = "Hosted Zone id of the desired Hosted Zone"
 value =  data.aws_route53_zone.mydomain.zone_id
}

output "mydomain_name" {
 description = "Hosted Zone name of the desired Hosted Zone"
 value =  data.aws_route53_zone.mydomain.name
}