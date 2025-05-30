# Local values for availability zones mapping
locals {
  # Create a map for NAT EIPs based on availability zones
  nat_eip_map = {
    for idx in range(2) : 
    "az${idx + 1}" => {
      index = idx
      az    = var.availability_zones[idx]
    }
  }
}
