variable "region" {
  type    = string
  description = "The AWS region where the infrastructure will be created."
}

variable "vpc_cidr" {
  type    = string
  description = "The cidr block of the VPC that the public subnet will reside in."
}

variable "public_subnet_cidr" {
  type    = string
  # TODO: Add description.
  # description = "value"
}

variable "namespace" {
  type    = string
  description = "Prefix for all object names."
}

variable "key_name" {
  type = string
  description = "The name of the AWS key used to ssh into the EC2 instances."
}