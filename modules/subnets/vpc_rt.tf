resource "aws_route_table" "public_rt" {
  for_each = local.public_subnets
  vpc_id   = var.vpc_id

  tags = {
    Name        = "${var.project_name}-${var.environment}-${each.key}-public-rt"
    Environment = var.environment
    Project     = var.project_name
    AZ          = each.value.availability_zone
    Type        = "Public"
  }

}

resource "aws_route" "public_route" {
  for_each = local.public_subnets
  route_table_id         = aws_route_table.public_rt[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internet_gateway_id
}
  
#============== Private Route Tables ==============
resource "aws_route_table" "private_rt" {
  for_each = local.private_route_tables
  vpc_id   = var.vpc_id

  tags = {
    Name        = "${var.project_name}-${var.environment}-${each.key}-private-rt"
    Environment = var.environment
    Project     = var.project_name
    AZ          = each.value.availability_zone
    Type        = "Private"
  }

}

resource "aws_route" "private_route" {
  for_each = local.private_route_tables
  route_table_id         = aws_route_table.private_rt[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main["public-${each.key}"].id
  
  depends_on = [aws_nat_gateway.main]
}

