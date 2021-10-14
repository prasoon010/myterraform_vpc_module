resource "aws_nat_gateway" "nat_gw" {
  count         = var.single_nat_gateway ? 1 : var.multi_az_nat_gateway ? max(var.private1_subnet["count"], var.private2_subnet["count"]) : 1
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.public_subnets[count.index].id

  tags = {
    Name = "${var.project}-${var.environment}-nat-gw-${count.index + 1}"
  }
  depends_on = [aws_internet_gateway.igw, aws_eip.nat_eip, aws_subnet.public_subnets]
}