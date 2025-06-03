resource "aws_route_table" "public_rt" {
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.project_name}-${var.environment}-public-rt"
    Environment = var.environment
    Project     = var.project_name
    Type        = "Public"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internet_gateway_id
  depends_on             = [aws_nat_gateway.main]
}

#============== Private Route Tables ==============
resource "aws_route_table" "private_rt" {
  for_each = local.private_route_tables
  vpc_id   = var.vpc_id

  tags = {
    Name        = "${var.project_name}-${var.environment}-${each.key}-private-rt"
    Environment = var.environment
    Project     = var.project_name
    AZ          = each.value.az_name
    Type        = "Private"
  }
  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_route" "private_route" {
  for_each               = local.private_route_tables
  route_table_id         = aws_route_table.private_rt[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main["public-${each.key}"].id

  depends_on = [aws_nat_gateway.main]
}

