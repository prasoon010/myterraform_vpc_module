
resource "aws_subnet" "public_subnets" {
  count                   = min(length(data.aws_availability_zones.available.names), var.public_subnet["count"])
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, var.cidr_newbit, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project}-${var.environment}-${var.public_subnet["name"]}-public-${count.index + 1}"
  }
}

resource "aws_subnet" "private1_subnets" {
  count                   = min(length(data.aws_availability_zones.available.names), var.private1_subnet["count"])
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, var.cidr_newbit, count.index + var.public_subnet["count"])
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project}-${var.environment}-${var.private1_subnet["name"]}-private-${count.index + 1}"
  }
}

resource "aws_subnet" "private2_subnets" {
  count                   = min(length(data.aws_availability_zones.available.names), var.private2_subnet["count"])
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, var.cidr_newbit, count.index + var.private1_subnet["count"] + var.public_subnet["count"])
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project}-${var.environment}-${var.private2_subnet["name"]}-private-${count.index + 1}"
  }
}