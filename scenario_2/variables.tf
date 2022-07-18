variable "public_key" {

  description = "Default public key"
  default     = "~/.ssh/id_rsa.pub"

}

variable "key_name" {

  description = "Default public key name"
  default     = "default"

}

variable "permit_cidrs" {

  description = "From public ip office permited"
  default     = []

}

variable "prefix" {

  default     = "demo"
  description = "Default prefix name"

}

variable "origin_vpc_cidr" {

  description = "Origin vpc cidr"
  default     = "172.20.0.0/16"

}


variable "origin_region" {

  description = "aws origin region"
  default     = "us-east-1"

}

variable "origin_profile" {

  description = "origin aws profile"
  default     = null

}

variable "destination_vpc_cidr" {

  description = "Destination vpc cidr"
  default     = "172.30.0.0/16"

}

variable "destination_region" {

  description = "aws destination region"
  default     = "us-east-1"

}

variable "destination_profile" {

  description = "destination aws profile"
  default     = null

}

