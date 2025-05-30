# Create the main VPC
resource "aws_vpc" "main" {
  # Set the CIDR block for the VPC
  cidr_block = var.vpc_cidr
  
  # Enable DNS resolution for instances in VPC
  enable_dns_support = var.enable_dns_support
  
  # Enable DNS hostnames for instances in VPC
  enable_dns_hostnames = var.enable_dns_hostnames
  
  # Tag the VPC with name and environment
  tags = {
    Name        = "${var.project_name}-${var.environment}-vpc"
    Environment = var.environment
    Project     = var.project_name
  }
}

