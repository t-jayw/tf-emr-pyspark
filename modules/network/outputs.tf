output "vpc_id" {
  value = aws_vpc.vpc.id
}
 
output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}
 
output "vpc_public_subnets" {
  # Result is a map of subnet id to cidr block, e.g.
  # { "subnet_1234" => "10.0.1.0/4", ...}
  value = {
    for subnet in aws_subnet.public :
    subnet.id => subnet.cidr_block
  }
}
 
output "vpc_public_subnet_ids" {
  # Result is a map of subnet id to cidr block, e.g.
  # { "subnet_1234" => "10.0.1.0/4", ...}
  value = [
    for subnet in aws_subnet.public :
    subnet.id
  ]
}

output "vpc_private_subnets" {
  # Result is a map of subnet id to cidr block, e.g.
  # { "subnet_1234" => "10.0.1.0/4", ...}
  value = {
    for subnet in aws_subnet.private :
    subnet.id => subnet.cidr_block
  }
}

output "key_name" {
  value = aws_key_pair.key121.key_name
}
