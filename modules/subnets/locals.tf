locals {
  # Create subnet configurations using maps
  public_subnets = {
    for subent_id, cidr in var.public_subnet_cidrs : "public-az${subent_id + 1}" => {
      cidr_block              = cidr
      availability_zone       = var.availability_zones[subent_id]
      map_public_ip_on_launch = true
      type                    = "Public"
      tier                    = "Public"
      az_index                = subent_id
    }
  }

  private_subnets = {
    for subent_id, cidr in var.private_subnet_cidrs :
    "private-az${(subent_id % 2) + 1}-${floor(subent_id / 2) + 1}" => {
      cidr_block              = cidr
      availability_zone       = var.availability_zones[subent_id % 2]
      map_public_ip_on_launch = false
      type                    = "Private"
      tier                    = subent_id < 2 ? "App" : "DB"
      az_index                = subent_id % 2
    }
  }

  all_subnets = merge(local.public_subnets, local.private_subnets)

  # Create route table mapping for private subnets
  private_route_tables = {
    for az_idx in range(2) : "az${az_idx + 1}" => {
      az_index = az_idx
      az_name  = var.availability_zones[az_idx]
    }
  }
}

