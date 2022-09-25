output "vpc_id" {
  value = aws_vpc.vpc.id
  description = "The id of the VPC this module creates."
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
  description = "The id of the public subnet."
}
