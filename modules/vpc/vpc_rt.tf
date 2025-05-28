resource "aws_route_table" "public_route_table" {
    vpc_id = var.vpc_id
    tags = {
        Name = "${var.name_prefix}-public-rt"
    }    

}

resource "aws_route" "public_internet_route" {
    route_table_id = aws_route_table.public_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_internet_gateway.id
  
}


resource "aws_route_table" "private_route_table" {
    vpc_id = var.vpc_id
    tags = {
        Name = "${var.name_prefix}-private-rt"
    }    
  
}
resource "aws_route" "private_nat_gateway_route" {
    for_each = {
        for subnet in aws_subnet.subnets :
        subnet.value.name => subnet.value
        if subnet.value.type == "private"
    }
    route_table_id = aws_route_table.public_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.
  
}
