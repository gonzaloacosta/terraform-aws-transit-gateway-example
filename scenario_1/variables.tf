variable "region" {

  description = "AWS Region"
  default     = "us-east-1"

}

variable "profile" {

  description = "AWS Profile"
  default     = "default"

}

variable "prefix" {

  description = "Default project prefix"
  default     = "demo-tgw"

}

variable "public_key" {

  description = "Defualt public key "
  default     = "~/.ssh/id_rsa.pub"

}

variable "origin_vpc_cidr" {

  description = "AWS VPC CIDR Origin"
  default     = "172.20.0.0/16"

}

variable "destination_vpc_cidr" {

  description = "AWS VPC CIDR Destination"
  default     = "172.30.0.0/16"

}

variable "permit_cidrs" {

  description = "From public ip office permmited"
  default     = []

}
