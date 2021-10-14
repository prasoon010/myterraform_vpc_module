resource "aws_internet_gateway" "igw" {
  count  = var.public_subnet["count"] > 0 ? 1 : 0
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "${var.project}-${var.environment}-igw"
  }
}