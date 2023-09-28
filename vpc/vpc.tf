# Create a VPC
resource "aws_vpc" "kiu_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "Kiu"
  }
}

# Create a public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.kiu_vpc.id
  cidr_block              = "10.0.1.0/24" # Define your public subnet CIDR block
  availability_zone       = "sa-east-1a"
  map_public_ip_on_launch = true
  tags = {
    "kubernetes.io/cluster/kiu-test" = "shared"
    "kubernetes.io/role/elb"                    = 1
  }
}

# Create a private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.kiu_vpc.id
  cidr_block        = "10.0.2.0/24" # Define your private subnet CIDR block
  availability_zone = "sa-east-1b"
  tags = {
    "kubernetes.io/cluster/kiu-test" = "shared"
    "kubernetes.io/role/elb"                    = 1
  }
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}
output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}
output "vpc_id" {
  value = aws_vpc.kiu_vpc.id
}