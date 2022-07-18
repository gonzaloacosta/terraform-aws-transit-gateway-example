resource "aws_security_group" "admin" {

  name        = "${var.name}-permit-ssh"
  description = "Allow TCP/22"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow SSH from enywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.permit_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "local" {

  name        = "${var.name}-permit-local"
  description = "Allow TCP/Local"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow All from vpc"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "public" {

  ami                         = data.aws_ssm_parameter.ami.value
  instance_type               = var.instance_type
  key_name                    = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [ aws_security_group.admin.id, aws_security_group.local.id ]
  subnet_id                   = module.vpc.public_subnets[0]

  tags = merge(local.tags, { Name = "${var.name}-public" })

}

resource "aws_instance" "private" {

  ami                    = data.aws_ssm_parameter.ami.value
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [ aws_security_group.local.id ]
  subnet_id              = module.vpc.private_subnets[0]

  tags = merge(local.tags, { Name = "${var.name}-private" })

}

