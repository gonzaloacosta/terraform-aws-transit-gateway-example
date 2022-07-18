variable "permit_cidrs" {

  description = "From public ip office permmited"

  default = [
    "190.103.144.52/32"
  ]
}

variable "vpc_cidr" {

  type    = string
  default = "172.20.0.0/16"

}

variable "instance_type" {

  default = "t3.micro"

}

variable "region" {

  default = "us-east-1"

}

variable "profile" {

  default = "default"

}

variable "name" {

  default = "demo"
  type    = string

}

variable "owner" {

  default = "gonzalo"
  type    = string

}

variable "environment" {

  default = "dev"
  type    = string

}

variable "key_name" {

  default = "default"
  type    = string

}

