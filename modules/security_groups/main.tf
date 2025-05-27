resource "aws_vpc_security_group_ingress_rule" "public_ingress_rule" {
  security_group_id = aws_security_group.public_sg.id
  description        = "Allow HTTP traffic to public security group"
  ip_protocol = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_ipv4         = "0.0.0.0/0"
  
}

resource "aws_vpc_security_group_ingress_rule" "private_ingress_rule" {
  security_group_id = aws_security_group.private_sg.id
  description        = "Allow HTTP traffic from the  public sg-group"
    ip_protocol = "tcp"
    
  
}