locals {

  subnets = cidrsubnets(var.vpc_cidr, 3, 3, 3, 3)

  tags = {
    env         = var.environment
    provisioner = "Terraform"
    owner       = var.owner
  }

}

module "vpc" {

  source                = "terraform-aws-modules/vpc/aws"
  name                  = var.name
  cidr                  = var.vpc_cidr
  private_subnets       = slice(local.subnets, 0, 1)
  private_subnet_suffix = "${var.name}-private"
  public_subnets        = slice(local.subnets, 1, 3)
  public_subnet_suffix  = "${var.name}-public"

  private_subnet_tags = { Name = "${var.name}-private" }
  public_subnet_tags  = { Name = "${var.name}-public" }

  public_route_table_tags  = { Name = "${var.name}-public" }
  private_route_table_tags = { Name = "${var.name}-private" }

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = true
  single_nat_gateway = true

  azs = [
    element(data.aws_availability_zones.available.names, 0),
    element(data.aws_availability_zones.available.names, 1)
  ]

  tags = merge({ Name = var.name }, local.tags)

}
