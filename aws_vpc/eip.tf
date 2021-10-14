resource "aws_eip" "nat_eip" {
  count      = var.single_nat_gateway ? 1 : var.multi_az_nat_gateway ? max(var.private1_subnet["count"], var.private2_subnet["count"]) : 1
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
}
