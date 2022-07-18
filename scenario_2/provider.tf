provider "aws" {

  alias = "origin"

  region  = var.origin_region
  profile = var.origin_profile
  #region = "us-east-1"
  #profile = "build38-development"

}

data "aws_caller_identity" "origin" {

  provider = aws.origin

}

provider "aws" {

  alias = "destination"

  region  = var.destination_region
  profile = var.destination_profile
  #region = "us-east-1"
  #profile = "build38-production"

}

data "aws_caller_identity" "destination" {

  provider = aws.destination

}
