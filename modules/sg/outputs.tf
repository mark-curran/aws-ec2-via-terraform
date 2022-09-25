output "public_sg_id" {
  value = aws_security_group.public_sg.id
  description = "Id of the public security group."
}
