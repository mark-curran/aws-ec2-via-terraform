output "vpc_id" {
    description = "The id of the VPC the VPC submodule creates."
    value = module.vpc.vpc_id
}

output "namespace" {
    description = "Prefix for all object names."
    value = var.namespace
}

output "key_name" {
    description = "The name of the AWS key used to ssh into the EC2 instances."
    value = var.key_name
}
