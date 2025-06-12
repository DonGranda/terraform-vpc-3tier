resource "aws_security_group" "web_sg" {
  name        = "${local.name_prefix}-web-sg"
  description = "Public security group for the web tier "
  vpc_id      = var.vpc_id
  tags = {
    Name = "${local.name_prefix}-web-sg"
    Tier = "web"
  }

}


resource "aws_security_group" "app_sg" {
  name        = "${local.name_prefix}-app-sg"
  description = "Private security group for the  app tier"
  vpc_id      = var.vpc_id
  tags = {
    Name = "${local.name_prefix}-app-sg"
    Tier = "app"
  }

}

resource "aws_security_group" "db_sg" {
  name        = "${local.name_prefix}-db-sg"
  description = "Private security group for the database tier"
  vpc_id      = var.vpc_id
  tags = {
    Name = "${local.name_prefix}-db-sg"
    Tier = "db"
  }

}