# subnets.tf

resource "aws_subnet" "private_one" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "private one"
  }
}

resource "aws_subnet" "private_two" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "private two"
  }
}

resource "aws_subnet" "public_one" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.101.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "public one"
  }
}

resource "aws_subnet" "public_two" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.102.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "public two"
  }
}