variable "vpc_cidr" {
  type    = string
  description = "The cidr block of the VPC that the public subnet will reside in."
}

variable "public_subnet_cidr" {
  type    = string
  description = "The cids block of the public subnet within the VPC."
}

variable "namespace" {
  type    = string
  description = "Prefix for all object names."
}