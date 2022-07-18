resource "aws_security_group_rule" "origin" {

  security_group_id = module.origin.local_security_group
  type              = "ingress"
  description       = "from ${local.destination_vpc_name} via transit gateway"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [var.destination_vpc_cidr]

}

resource "aws_security_group_rule" "destination" {

  security_group_id = module.destination.local_security_group
  type              = "ingress"
  description       = "from ${local.origin_vpc_name} via transit gateway"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [var.origin_vpc_cidr]

}
