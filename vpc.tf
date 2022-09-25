resource "aws_vpc" "vpc" {
  cidr_block                       = var.cidr
  instance_tenancy                 = "default"
  enable_dns_hostnames = true

  tags = {
    Name      = "${var.namespace}-vpc"
    NameSpace = var.namespace
  }
}

resource "aws_subnet" "public_subnet" {
  cidr_block              = var.public_subnet_cidr
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true

  tags = {
    Name      = "${var.namespace}-public-subnet"
    Namespace = var.namespace
  }

  depends_on = [aws_vpc.vpc]
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name      = "${var.namespace}-internet-gateway"
    Namespace = var.namespace
  }

  depends_on = [aws_vpc.vpc]
}


resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0" # This argument is required.
    # There are many possible second arguments, for internet access we use...
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name      = "${var.namespace}-public-route-table"
    Namespace = var.namespace
  }

  depends_on = [aws_internet_gateway.internet_gateway]
}

resource "aws_route_table_association" "public_route_table_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet.id

  depends_on = [aws_subnet.public_subnet, aws_route_table.public_route_table]
}
