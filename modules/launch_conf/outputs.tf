output "launch_conf_name" {
  value = aws_launch_configuration.launch_conf.name
  description = "Name of the launch configuration."
}