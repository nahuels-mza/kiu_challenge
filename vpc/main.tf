# Define two availability zones (AZs)
data "aws_availability_zones" "available" {
  state = "available"
}
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
  count                   = 2
  vpc_id                  = aws_vpc.kiu_vpc.id
  cidr_block              = element(["10.0.1.0/24", "10.0.2.0/24"], count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    "kubernetes.io/cluster/kiu-test" = "shared"
    "kubernetes.io/role/elb"         = 1
  }
}

# Create a private subnet
resource "aws_subnet" "private_subnet" {
  count             = 1
  vpc_id            = aws_vpc.kiu_vpc.id
  cidr_block        = element(["10.0.3.0/24", ], count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    "kubernetes.io/cluster/kiu-test" = "shared"
    "kubernetes.io/role/elb"         = 1
  }
  map_public_ip_on_launch = false
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet[*].id
}

output "vpc_id" {
  value = aws_vpc.kiu_vpc.id
}