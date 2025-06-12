resource "aws_subnet" "all_subnets" {
  for_each = local.all_subnets

  vpc_id                  = var.vpc_id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch

  tags = {
    Name        = "${var.project_name}-${var.environment}-${each.key}"
    Type        = each.value.type
    Environment = var.environment
    Project     = var.project_name
    AZ          = each.value.availability_zone
    Tier        = each.value.tier
  }
}

resource "aws_nat_gateway" "main" {
  for_each      = local.public_subnets
  subnet_id     = aws_subnet.all_subnets[each.key].id
  allocation_id = var.nat_eip_ids["az${each.value.az_index + 1}"]
  depends_on    = [var.internet_gateway_id]
  tags = {
    Name        = "${var.project_name}-${var.environment}-nat-gw-az${each.value.az_index + 1}"
    Environment = var.environment
    Project     = var.project_name
    AZ          = each.value.availability_zone
  }
}

