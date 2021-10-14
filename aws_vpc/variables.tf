variable "profile" {
  description = "aws profile"
  default     = "default"
  type        = string
}

variable "project" {
  description = "Name of the project"
  default     = "demo"
  type        = string
}

variable "environment" {
  description = "Name of the project environment"
  default     = "demo"
  type        = string
}

variable "region" {
  description = "Region of VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  default     = "172.16.0.0/16"
  type        = string
}

variable "cidr_newbit" {
  description = "CIDR block newbits for VPC"
  default     = 5
  type        = number
}

variable "public_subnet" {
  description = "A list of public subnets inside the VPC"
  default = {
    count = 0
  }
  type = map(any)
}

variable "private1_subnet" {
  description = "A list of private subnets inside the VPC"
  default = {
    name  = "app-layer"
    count = 0
  }
  type = map(any)
}

variable "private2_subnet" {
  description = "A list of private subnets inside the VPC"
  default = {
    name  = "db-layer"
    count = 0
  }
  type = map(any)
}

variable "multi_az_nat_gateway" {
  description = "Place a NAT gateway in each AZ"
  default     = true
  type        = bool
}

variable "single_nat_gateway" {
  description = "Use a single NAT gateway to serve outbound traffic for all AZs"
  default     = false
  type        = bool
}