resource "aws_security_group" "public_sg" {
    name=  "${var.name_prefix}-public-sg"
    description = "Public security group for ${var.name_prefix}"
    vpc_id = var.vpc_id
  
}


resource "aws_security_group" "app-tier_sg" {
    name=  "${var.name_prefix}-app-tier-sg"
    description = "Private security group for the${var.name_prefix} app tier resources"
    vpc_id = var.vpc_id
  
}


resource "aws_security_group" "Database_sg" {
    name=  "${var.name_prefix}-DB-tier-sg"
    description = "Private security group for ${var.name_prefix}"
    vpc_id = var.vpc_id
  
}