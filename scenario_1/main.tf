resource "aws_key_pair" "devops" {

  key_name   = var.key_name
  public_key = file(var.public_key)

}

resource "aws_ec2_transit_gateway" "origin" {

  description                    = local.origin_vpc_name
  auto_accept_shared_attachments = "enable"

  tags = {
    Name = local.origin_vpc_name
  }

}

resource "aws_ec2_transit_gateway_vpc_attachment" "origin" {

  transit_gateway_id = aws_ec2_transit_gateway.origin.id
  vpc_id             = module.origin.vpc_id
  subnet_ids         = module.origin.private_subnets

  tags = {
    Name = local.origin_vpc_name
  }

}

resource "aws_ec2_transit_gateway_vpc_attachment" "destination" {

  transit_gateway_id = aws_ec2_transit_gateway.origin.id
  vpc_id             = module.destination.vpc_id
  subnet_ids         = module.destination.private_subnets

  tags = {
    Name = local.destination_vpc_name
  }

}

resource "aws_route" "origin-to-destination" {

  depends_on = [aws_ec2_transit_gateway_vpc_attachment.origin]

  route_table_id         = module.origin.private_route_table_ids[0]
  destination_cidr_block = var.destination_vpc_cidr
  transit_gateway_id     = aws_ec2_transit_gateway.origin.id
}

resource "aws_route" "destination-to-origin" {

  depends_on = [aws_ec2_transit_gateway_vpc_attachment.destination]

  route_table_id         = module.destination.private_route_table_ids[0]
  destination_cidr_block = var.origin_vpc_cidr
  transit_gateway_id     = aws_ec2_transit_gateway.origin.id

}
