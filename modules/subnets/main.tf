resource "aws_subnet" "subnets" {
  for_each = {
    for subnet in local.subnet_configs :
    subnet.name => subnet
  }

  vpc_id            = var.vpc_id
  cidr_block        = cidrsubnet(var.vpc_cidr_block_base, 8, each.value.cidr_suffix_index)
  availability_zone = each.value.az
  map_public_ip_on_launch = each.value.type == "public" ? true : false

  tags = {
    Name = each.value.name
    Type = each.value.type
  }
}
