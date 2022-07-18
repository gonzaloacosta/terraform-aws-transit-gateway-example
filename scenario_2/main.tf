resource "aws_key_pair" "origin_key" {

  provider = aws.origin

  key_name   = var.key_name
  public_key = file(var.public_key)

}

resource "aws_key_pair" "destination_key" {

  provider = aws.destination

  key_name   = var.key_name
  public_key = file(var.public_key)
}

resource "aws_ec2_transit_gateway" "origin" {

  provider = aws.origin

  description                    = local.origin_vpc_name
  auto_accept_shared_attachments = "enable"

  tags = {

    Name = local.origin_vpc_name

  }

}

resource "aws_ec2_transit_gateway_vpc_attachment" "origin" {

  provider = aws.origin

  transit_gateway_id = aws_ec2_transit_gateway.origin.id
  vpc_id             = module.origin.vpc_id
  subnet_ids         = module.origin.private_subnets

  tags = {
    Name = local.origin_vpc_name
  }

}

resource "aws_ram_resource_share" "origin" {

  provider = aws.origin

  count = var.destination_profile != var.origin_profile ? 1 : 0

  name                      = local.origin_vpc_name
  allow_external_principals = true

}

resource "aws_ram_resource_association" "origin" {

  provider = aws.origin

  count = var.destination_profile != var.origin_profile ? 1 : 0

  resource_arn       = aws_ec2_transit_gateway.origin.arn
  resource_share_arn = aws_ram_resource_share.origin[count.index].arn

}


resource "aws_ram_principal_association" "destination" {

  provider = aws.origin

  count = var.destination_profile != var.origin_profile ? 1 : 0

  principal          = data.aws_caller_identity.destination.account_id
  resource_share_arn = aws_ram_resource_share.origin[count.index].arn

}


resource "aws_ec2_transit_gateway_vpc_attachment" "destination" {

  depends_on = [aws_ram_principal_association.destination]

  provider = aws.destination

  transit_gateway_id = aws_ec2_transit_gateway.origin.id
  vpc_id             = module.destination.vpc_id
  subnet_ids         = module.destination.private_subnets

  tags = {
    Name = local.destination_vpc_name
  }

}

# resource "aws_ec2_transit_gateway_vpc_attachment_accepter" "destination" {

#   provider = aws.destination

#   transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.origin.id

#   tags = {
#     Name = local.destination_vpc_name
#   }

# }

resource "aws_route" "origin_to_destination" {

  depends_on = [aws_ec2_transit_gateway_vpc_attachment.origin]

  provider = aws.origin

  route_table_id         = module.origin.private_route_table_ids[0]
  destination_cidr_block = var.destination_vpc_cidr
  transit_gateway_id     = aws_ec2_transit_gateway.origin.id

}

resource "aws_route" "destination_to_origin" {

  depends_on = [aws_ec2_transit_gateway_vpc_attachment.destination]

  provider = aws.destination

  route_table_id         = module.destination.private_route_table_ids[0]
  destination_cidr_block = var.origin_vpc_cidr
  transit_gateway_id     = aws_ec2_transit_gateway.origin.id

}
