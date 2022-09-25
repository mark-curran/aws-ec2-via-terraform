variable "namespace" {
  type    = string
  description = "Prefix for all object names."
}

variable "security_group_id" {
    type = string
    description = "Id of the public security group to which the instance belongs."
}

variable "key_name" {
    type = string
    description = "Name of the AWS key that is will be used to access instances created with this config."
}