# security_groups.tf

resource "aws_security_group" "sg_ec2" {
  name        = "ec2 security group"
  description = "ec2"
  vpc_id      = aws_vpc.main.id
}

resource "aws_vpc_security_group_ingress_rule" "ingress_5000" {
  security_group_id = aws_security_group.sg_ec2.id
  referenced_security_group_id = aws_security_group.sg_lb.id
  from_port         = 5000
  ip_protocol       = "tcp"
  to_port           = 5000
}

resource "aws_vpc_security_group_egress_rule" "exgress_5000" {
  security_group_id = aws_security_group.sg_ec2.id
  referenced_security_group_id = aws_security_group.sg_lb.id
  from_port         = 5000
  ip_protocol       = "tcp"
  to_port           = 5000
}

resource "aws_security_group" "sg_lb" {
  name        = "lb"
  description = "lb"
  vpc_id      = aws_vpc.main.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4_public" {
  security_group_id = aws_security_group.sg_lb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "lb_to_ec2_5000" {
  security_group_id = aws_security_group.sg_lb.id
  referenced_security_group_id = aws_security_group.sg_ec2.id
  from_port         = 5000
  ip_protocol       = "tcp"
  to_port           = 5000
}

resource "aws_vpc_security_group_egress_rule" "allow_http_ipv4_public" {
  security_group_id = aws_security_group.sg_lb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}