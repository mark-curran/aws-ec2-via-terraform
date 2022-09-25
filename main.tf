terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  namespace = var.namespace
  public_subnet_cidr = var.public_subnet_cidr
}

module "sg" {
  source = "./modules/sg"
  namespace = var.namespace
  vpc_id = module.vpc.vpc_id
}

module "launch_conf" {
  source = "./modules/launch_conf"
  namespace = var.namespace
  key_name = var.key_name
  security_group_id =module.sg.public_sg_id
}

module "autoscaling" {
  source = "./modules/autoscaling"
  namespace = var.namespace
  public_subnet_id = module.vpc.public_subnet_id
  launch_conf_name = module.launch_conf.launch_conf_name
}