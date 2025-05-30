resource "aws_subnet" "all_subnets" {
  for_each = local.all_subnets
  
  # Associate with our VPC
  vpc_id = var.vpc_id
  
  # Set CIDR block from local configuration
  cidr_block = each.value.cidr_block
  
  # Set availability zone from local configuration
  availability_zone = each.value.availability_zone
  
  # Set public IP assignment based on subnet type
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  
  # Tag each subnet with comprehensive information
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
  for_each = local.public_subnets
  
  # Place NAT Gateway in respective public subnet
  subnet_id = aws_subnet.all_subnets[each.key].id
  
  # Associate with respective Elastic IP
  allocation_id = var.nat_eip_ids["az${each.value.az_index + 1}"]
  
  # Ensure Internet Gateway exists before creating NAT Gateway
  depends_on = [var.internet_gateway_id]
  
  # Tag the NAT Gateway
  tags = {
    Name        = "${var.project_name}-${var.environment}-nat-gw-az${each.value.az_index + 1}"
    Environment = var.environment
    Project     = var.project_name
    AZ          = each.value.availability_zone
  }
}

resource "aws_route_table" "public" {
  # Associate with our VPC
  vpc_id = var.vpc_id
  
  # Route all traffic (0.0.0.0/0) to Internet Gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }
  
  # Tag the public route table
  tags = {
    Name        = "${var.project_name}-${var.environment}-public-rt"
    Type        = "Public"
    Environment = var.environment
    Project     = var.project_name
  }
}


resource "aws_route_table" "private" {
  for_each = local.private_route_tables
  
  # Associate with our VPC
  vpc_id = var.vpc_id
  
  # Route all traffic (0.0.0.0/0) to respective NAT Gateway
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main["public-${each.key}"].id
  }
  
  # Tag the private route table
  tags = {
    Name        = "${var.project_name}-${var.environment}-private-rt-${each.key}"
    Type        = "Private"
    Environment = var.environment
    Project     = var.project_name
    AZ          = each.value.az_name
  }
}


# Associate public subnets with public route table
resource "aws_route_table_association" "public" {
  for_each = local.public_subnets
  
  # Specify public subnet ID
  subnet_id = aws_subnet.all_subnets[each.key].id
  
  # Associate with public route table
  route_table_id = aws_route_table.public.id
}

# Associate private subnets with private route tables
resource "aws_route_table_association" "private" {
  for_each = local.private_subnets
  
  # Specify private subnet ID
  subnet_id = aws_subnet.all_subnets[each.key].id
  
  # Associate with appropriate route table based on AZ
  route_table_id = aws_route_table.private["az${each.value.az_index + 1}"].id
}
