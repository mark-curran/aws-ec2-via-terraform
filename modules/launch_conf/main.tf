# TODO: Add variables file.
# TODO: Add module docstring.
# TODO: Add README.md

variable "namespace" {}
variable "security_group_id" {}
variable "key_name" {}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_launch_configuration" "launch_conf" {
  name                        = "${var.namespace}-launch-conf"
  image_id                    = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  # security_groups             = [aws_security_group.public_sg.id]
  security_groups             = [var.security_group_id]
  associate_public_ip_address = true
  key_name = var.key_name
  # TODO: Write the user_data file.
}

output "launch_conf_name" {
  value = aws_launch_configuration.launch_conf.name
  description = "Name of the launch configuration."
}