# Create a VPC for the region associated with the AZ
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
 
  tags = {
    Name        = "emr-${var.infra_env}-vpc"
    Environment = var.infra_env
    ManagedBy   = "terraform"
  }
}
 
# Create 1 public subnets for each AZ within the regional VPC
resource "aws_subnet" "public" {
  for_each = var.public_subnet_numbers
 
  vpc_id            = aws_vpc.vpc.id
  availability_zone = each.key
 
  # 2,048 IP addresses each
  cidr_block = "10.1.0.0/17"
 
  tags = {
    Name        = "tjw-${var.infra_env}-public-subnet"
    Role        = "public"
    Environment = var.infra_env
    ManagedBy   = "terraform"
    Subnet      = "${each.key}-${each.value}"
  }
}
 
# Create 1 private subnets for each AZ within the regional VPC
resource "aws_subnet" "private" {
  for_each = var.private_subnet_numbers
 
  vpc_id            = aws_vpc.vpc.id
  availability_zone = each.key
 
  # 2,048 IP addresses each
  cidr_block = "10.1.128.0/18"
 
  tags = {
    Name        = "tjw-${var.infra_env}-private-subnet"
    Role        = "private"
    Environment = var.infra_env
    ManagedBy   = "terraform"
    Subnet      = "${each.key}-${each.value}"
  }
}


//gateways.tf
resource "aws_internet_gateway" "test-env-gw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "test-env-gw"
  }
}


//route_table.tf
resource "aws_route_table" "route-table-test-env" {
  vpc_id = aws_vpc.vpc.id
route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test-env-gw.id
  }
tags =  {
    Name = "test-env-route-table"
  }
}

resource "aws_route_table_association" "subnet-association" {
  subnet_id      = aws_subnet.public["us-east-1a"].id
  route_table_id = "${aws_route_table.route-table-test-env.id}"
}


# Key
resource "tls_private_key" "oskey" {
  algorithm = "RSA"
}

resource "local_file" "myterrakey" {
  content  = tls_private_key.oskey.private_key_pem
  filename = "myterrakey.pem"
}

resource "aws_key_pair" "key121" {
  key_name   = "myterrakey"
  public_key = tls_private_key.oskey.public_key_openssh
}
