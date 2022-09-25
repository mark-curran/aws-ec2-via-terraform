variable "region" {
  type    = string
  default = "ap-southeast-2"
}

variable "cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "namespace" {
  type    = string
  description = "Prefix for all object names."
}

variable "key_name" {
  type = string
  description = "The name of the AWS key ssh into the EC2 instances."
}