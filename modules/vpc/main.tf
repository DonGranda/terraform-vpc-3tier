resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
   Name = "${var.name_prefix}-vpc"
  }
  
}


resource "aws_internet_gateway" "main_internet_gateway" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.name_prefix}-internet-gateway"
  }
}






