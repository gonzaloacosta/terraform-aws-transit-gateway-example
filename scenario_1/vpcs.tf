module "origin" {

  source = "./modules/vpc"

  vpc_cidr     = var.origin_vpc_cidr
  name         = local.origin_vpc_name
  region       = var.region
  profile      = var.profile
  key_name     = var.key_name
  permit_cidrs = var.permit_cidrs

}

module "destination" {

  source = "./modules/vpc"

  vpc_cidr     = var.destination_vpc_cidr
  name         = local.destination_vpc_name
  region       = var.region
  profile      = var.profile
  key_name     = var.key_name
  permit_cidrs = var.permit_cidrs

}

