module "network" {
  source = "../network"
}

resource "aws_security_group" "jenkins_sg" {
  name   = "jenkins_sg"
  vpc_id = module.network.vpc_id

  tags = {
    Name = "jenkins_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.jenkins_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_jenkins_port" {
  security_group_id = aws_security_group.jenkins_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.jenkins_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_instance" "jenkins" {
  ami                         = "ami-0053d231eed60f51b"
  instance_type               = "t3.micro"
  subnet_id                   = module.network.subnet_id
  associate_public_ip_address = true
  key_name                    = "ec2"
  vpc_security_group_ids      = [aws_security_group.jenkins_sg.id]

  root_block_device {
    volume_size = 30
  }

  tags = {
    Name = "Jenkins"
  }
}