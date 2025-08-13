#route_tables.tf

resource "aws_route_table" "route_to_gw" {
  vpc_id = aws_vpc.main. id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "public_one" {
  route_table_id = aws_route_table.route_to_gw.id
  subnet_id = aws_subnet.public_one.id
}

resource "aws_route_table_association" "public_two" {
  route_table_id = aws_route_table.route_to_gw.id
  subnet_id = aws_subnet.public_two.id
}