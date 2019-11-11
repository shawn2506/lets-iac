resource "aws_vpc" "apex-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "apex-vpc"
  }
}

resource "aws_subnet" "apex-public-1" {
  vpc_id                  = aws_vpc.apex-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "apex-public-1"
  }
}

resource "aws_subnet" "apex-public-2" {
  vpc_id                  = aws_vpc.apex-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "apex-public-2"
  }
}

resource "aws_subnet" "apex-private-1" {
  vpc_id                  = aws_vpc.apex-vpc.id
  cidr_block              = "10.0.11.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "apex-private-1"
  }
}

resource "aws_subnet" "apex-private-2" {
  vpc_id                  = aws_vpc.apex-vpc.id
  cidr_block              = "10.0.12.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "apex-private-2"
  }
}

resource "aws_internet_gateway" "apex-vpc-gw" {
  vpc_id = aws_vpc.apex-vpc.id

  tags = {
    Name = "apex-vpc-gw"
  }
}

resource "aws_route_table" "apex-public-rt" {
  vpc_id = aws_vpc.apex-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.apex-vpc-gw.id
  }

  tags = {
    Name = "apex-public-rt"
  }
}

resource "aws_route_table_association" "association-public-1a" {
  subnet_id      = aws_subnet.apex-public-1.id
  route_table_id = aws_route_table.apex-public-rt.id
}

resource "aws_route_table_association" "association-public-1b" {
  subnet_id      = aws_subnet.apex-public-2.id
  route_table_id = aws_route_table.apex-public-rt.id
}
