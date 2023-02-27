variable "public_subnet_numbers" {
  type = map(number)
 
  description = "Map of AZ to a number that should be used for public subnets"
 
  default = {
    "us-east-1a" = 1
  }
}
 
variable "private_subnet_numbers" {
  type = map(number)
 
  description = "Map of AZ to a number that should be used for private subnets"
 
  default = {
    "us-east-1a" = 1
  }
}
 
variable "vpc_cidr" {
  type        = string
  description = "The IP range to use for the VPC"
  default     = "10.1.0.0/16"
}
 
variable "infra_env" {
  type        = string
  description = "infrastructure environment"
}
