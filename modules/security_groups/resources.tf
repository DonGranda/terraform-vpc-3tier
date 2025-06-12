resource "aws_vpc_security_group_ingress_rule" "public_ingress_rule" {
  for_each          = toset(["22", "80", "443"])
  security_group_id = aws_security_group.web_sg.id
  description       = "Allow HTTP traffic to public security group"
  ip_protocol       = "tcp"
  from_port         = each.value
  to_port           = each.value
  cidr_ipv4         = "0.0.0.0/0"

}

resource "aws_vpc_security_group_egress_rule" "public_egress_rule" {
  security_group_id = aws_security_group.web_sg.id
  description       = "Allow HTTP traffic to public security group"
  ip_protocol       = -1
  cidr_ipv4         = "0.0.0.0/0"

}

###============== App Tier Security Group Rules ================

resource "aws_vpc_security_group_ingress_rule" "app_ingress_rule" {
  security_group_id            = aws_security_group.app_sg.id
  description                  = "Allow HTTP traffic from the  public sg-group"
  ip_protocol                  = "tcp"
  from_port                    = 8080
  to_port                      = 8080
  referenced_security_group_id = aws_security_group.web_sg.id
}

resource "aws_vpc_security_group_egress_rule" "app_egress_rule" {
  security_group_id = aws_security_group.app_sg.id
  description       = "Allow traffic out of the app-tier security group"
  ip_protocol       = -1
  cidr_ipv4         = "0.0.0.0/0"
}

###============== DB Tier Security Group Rules ================

resource "aws_vpc_security_group_ingress_rule" "db_ingress_rule" {
  security_group_id            = aws_security_group.db_sg.id
  description                  = "Allow MySQL traffic from the app-tier security group"
  ip_protocol                  = "tcp"
  from_port                    = 3306
  to_port                      = 3306
  referenced_security_group_id = aws_security_group.app_sg.id
}

resource "aws_vpc_security_group_egress_rule" "db_egress_rule" {
  security_group_id = aws_security_group.db_sg.id
  description       = "Allow all outbound traffic from the DB tier security group"
  ip_protocol       = -1
  cidr_ipv4         = "0.0.0.0/0"
}


