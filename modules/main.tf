provider "aws" {
    version = "~> 2.0"
    region  = var.region
}

resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = var.vpc_tagkey
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.subnet_az

  tags = {
    Name = var.subnet_tagkey
  }
}

resource "aws_security_group" "allow_traffic" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "aws_vpc.my_vpc.id"

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

data "aws_ami" "myami" {  
  filter {
    name = "image-id"
    values = [var.ami_id]
  }
  most_recent = true
  owners = [var.ami_owner]
}


resource "aws_instance" "instance" {
  ami           = var.ami_id
  instance_type = var.inst_type
  availability_zone = var.subnet_az
  vpc_security_group_ids  = ["aws_security_group.allow_traffic.id"]
  tags = {
    Name = "sre-instance"
  }
}

resource "aws_ebs_volume" "ebs" {
  availability_zone = "us-east-1e"
  size              = 20
}


resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs.id
  instance_id = aws_instance.instance.id
}
