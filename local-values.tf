#Define local values
locals{
    owners = var.business_division
    environment = var.Environment
    #name = "${var.business_division}-${var.Envrionment}"
    name = "${local.owners}-${local.environment}"
    common_tags = {
        owners = local.owners
        environment = local.environment
    }
}
