variable "launch_conf_name" {
  type = string
  description = "The autoscaling group's launch configuration."
}

variable "namespace" {
  type    = string
  description = "Prefix for all object names."
}

variable "subnet_id" {
  type = string
  description = "Subnet id of the autoscaling group."
}
