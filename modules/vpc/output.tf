output "vpc_id" {

  description = "The ID of the VPC"
  value       = module.vpc.vpc_id

}

output "vpc_arn" {

  description = "The ARN of the VPC"
  value       = module.vpc.vpc_arn

}

output "private_subnets" {

  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets

}

output "private_subnets_cidr_blocks" {

  description = "List of cidr_blocks of private subnets"
  value       = module.vpc.private_subnets_cidr_blocks

}

output "public_subnets" {

  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets

}

output "public_subnets_cidr_blocks" {

  description = "List of cidr_blocks of public subnets"
  value       = module.vpc.public_subnets_cidr_blocks

}

output "public_route_table_ids" {

  description = "List of IDs of public route tables"
  value       = module.vpc.public_route_table_ids

}

output "private_route_table_ids" {

  description = "List of IDs of private route tables"
  value       = module.vpc.private_route_table_ids

}

output "local_security_group" {

  description = "Local security group id"
  value       = aws_security_group.local.id

}

output "admin_security_group" {

  description = "Admin security group id"
  value       = aws_security_group.admin.id

}

output "instance_public_ips" {

  value = [
    aws_instance.public.public_ip,
    aws_instance.public.private_ip
  ]

}

output "instance_private_ips" {

  value = [aws_instance.private.private_ip]

}
