resource "aws_route_table_association" "public_rt_association" {
 for_each = local.public_subnets
 subnet_id = aws_subnet.all_subnets[each.key].id
 route_table_id = aws_route_table.public_rt[each.key].id
}

#================= Private Route Table Associations ==============

resource "aws_route_table_association" "private_rt_association" {
 for_each = local.private_subnets
 subnet_id = aws_subnet.all_subnets[each.key].id
 route_table_id = aws_route_table.private_rt["az${each.value.az_index + 1}"].id
}