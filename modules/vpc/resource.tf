# Create Internet Gateway for public internet access
resource "aws_internet_gateway" "main" {
  # Attach to our VPC
  vpc_id = aws_vpc.main.id
  
  # Tag the Internet Gateway
  tags = {
    Name        = "${var.project_name}-${var.environment}-igw"
    Environment = var.environment
    Project     = var.project_name
  }
}

# Create Elastic IP for NAT Gateway (2 EIPs - one per AZ)
resource "aws_eip" "nat" {
  # Create EIPs using for_each with AZ mapping
  for_each = local.nat_eip_map
  
  # Specify that this EIP is for VPC use
  domain = "vpc"
  
  # Ensure Internet Gateway is created first
  depends_on = [aws_internet_gateway.main]
  
  # Tag the Elastic IP
  tags = {
    Name        = "${var.project_name}-${var.environment}-eip-${each.key}"
    Environment = var.environment
    Project     = var.project_name
    AZ          = each.value.az
  }
}
