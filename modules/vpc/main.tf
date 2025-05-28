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


resource "aws_nat_gateway" "vpc_nat_gateway" {
  for_each = {
  for subnet in aws_subnet.subnets :
  subnet.value.name => subnet.value
  if subnet.value.tags.Type == "public"
  }
  allocation_id = aws_eip.nat_gateway_eip[each.key].id
  subnet_id     = aws_subnet.subnets[each.key].id
  tags = {
    Name = "nat-gateway-${each.key}-${var.name_prefix}"
  }
  
}



