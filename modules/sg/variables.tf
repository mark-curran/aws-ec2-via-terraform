variable "namespace" {
  type    = string
  description = "Prefix for all object names."
}

variable vpc_id {
    type = string
    description = "Id of the VPC this security group will be associated with."
}
