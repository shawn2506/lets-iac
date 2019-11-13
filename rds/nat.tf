resource "aws_eip" "nat-eip" {
  vpc = true
}

resource "aws_nat_gateway" "apex-nat-gw" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = aws_subnet.apex-public-1.id
  depends_on    = [aws_internet_gateway.apex-vpc-gw]
}

resource "aws_route_table" "apex-private-rt" {
  vpc_id = aws_vpc.apex-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.apex-nat-gw.id
  }

  tags = {
    Name = "apex-private-rt"
  }
}

resource "aws_route_table_association" "association-private-1a" {
  subnet_id      = aws_subnet.apex-private-1.id
  route_table_id = aws_route_table.apex-private-rt.id
}

resource "aws_route_table_association" "association-private-1b" {
  subnet_id      = aws_subnet.apex-private-2.id
  route_table_id = aws_route_table.apex-private-rt.id
}

