output "origin_vpc_id" {

  description = "origin vpc id"
  value       = module.origin.vpc_id

}

output "destination_vpc_id" {

  description = "destination vpc id"
  value       = module.destination.vpc_id

}

output "origin_ips" {

  value = {
    "public"  = module.origin.instance_public_ips
    "private" = module.origin.instance_private_ips
  }

}

output "destination_ips" {

  value = {
    "public"  = module.destination.instance_public_ips
    "private" = module.destination.instance_private_ips
  }

}
