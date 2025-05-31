resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name        = "${var.project_name}-${var.environment}-igw"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_eip" "nat" {
  for_each = local.nat_eip_map
  
  domain = "vpc"
  
# future proofing. EIP will be deleted first before the igw and vpc . aws cannot a igw is the EIP are attached to it.
  depends_on = [aws_internet_gateway.main]
  
  tags = {
    Name        = "${var.project_name}-${var.environment}-eip-${each.key}"
    Environment = var.environment
    Project     = var.project_name
    AZ          = each.value.az
  }
}
