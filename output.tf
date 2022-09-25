output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "namespace" {
  value = var.namespace
}

output "key_name" {
  value = var.key_name
}