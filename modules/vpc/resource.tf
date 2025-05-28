resource "aws_eip" "nat_gateway_eip" {
  for_each = {
    for subnet in aws_subnet.subnets:
    subnet.value.name => subnet.value
    if subnet.value.type== "public"
  }
  tags = {
    Name = "${var.name_prefix}-nat-gateway-eip"
  }
  
}

