resource "aws_eip" "nat_gateway_eip" {
  for_each = {
    for subnet in aws_subnet.subnets:
    subnet.value.name => subnet.value
    if subnet.value.tags.Type== "public"
  }
  tags = {
    Name = "${var.name_prefix}-nat-gateway-eip"
  }
  
}

