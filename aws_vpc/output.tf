output "vpc_id" {
  value       = aws_vpc.myvpc.id
  description = "VPC ID"
}

output "public_subnet_ids" {
  value       = aws_subnet.public_subnets.*.id
  description = "List of public subnet IDs"
}

output "private1_subnet_ids" {
  value       = aws_subnet.private1_subnets.*.id
  description = "List of private-1 subnet IDs"
}

output "private2_subnet_ids" {
  value       = aws_subnet.private2_subnets.*.id
  description = "List of private-2 subnet IDs"
}

output "cidr_block" {
  value       = var.vpc_cidr
  description = "The CIDR block associated with the VPC"
}

output "nat_gateway_ips" {
  value       = aws_eip.nat_eip.*.public_ip
  description = "List of Elastic IPs associated with NAT gateways"
}