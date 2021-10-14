resource "aws_route_table" "public_rt" {
  count  = var.public_subnet["count"] > 0 ? 1 : 0
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "${var.project}-${var.environment}-public-rt"
  }

}

resource "aws_route_table" "private_rt" {
  count  = max(var.private1_subnet["count"], var.private2_subnet["count"]) > 0 ? 1 : 0
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "${var.project}-${var.environment}-private-rt"
  }

}

resource "aws_route" "public_igw_route" {
  route_table_id         = aws_route_table.public_rt[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw[0].id
  depends_on             = [aws_route_table.public_rt, aws_internet_gateway.igw]
}

resource "aws_route" "private_nat_gw_route" {
  count                  = var.single_nat_gateway ? 1 : var.multi_az_nat_gateway ? max(var.private1_subnet["count"], var.private2_subnet["count"]) : 1
  route_table_id         = aws_route_table.private_rt[0].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw[count.index].id
  depends_on             = [aws_route_table.private_rt, aws_nat_gateway.nat_gw]
}

resource "aws_route_table_association" "public_rt_association" {
  count          = var.public_subnet["count"]
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rt[0].id
}

resource "aws_route_table_association" "private_rt_association1" {
  count          = var.private1_subnet["count"]
  subnet_id      = aws_subnet.private1_subnets[count.index].id
  route_table_id = aws_route_table.private_rt[0].id
}

resource "aws_route_table_association" "private_rt_association2" {
  count          = var.private2_subnet["count"]
  subnet_id      = aws_subnet.private2_subnets[count.index].id
  route_table_id = aws_route_table.private_rt[0].id
}

