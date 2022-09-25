resource "aws_autoscaling_group" "autoscaling_group" {
  name                = "${var.namespace}-asg"
  max_size            = 1
  min_size            = 0
  vpc_zone_identifier = [aws_subnet.public_subnet.id]
  default_cooldown    = 120

  launch_configuration = aws_launch_configuration.launch_conf.name

}

resource "aws_autoscaling_policy" "start_single_instance" {
  name                   = "${var.namespace}-autoscaling-policy-single-instance"
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.name
  adjustment_type        = "ExactCapacity"
  scaling_adjustment     = 1
  cooldown               = 120
}

resource "aws_autoscaling_policy" "stop_all_instances" {
  name                   = "${var.namespace}-autoscaling-policy-stop-all"
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.name
  adjustment_type        = "ExactCapacity"
  scaling_adjustment     = 0
  cooldown               = 120
}

resource "aws_cloudwatch_metric_alarm" "alarm_network_packets_in" {
  alarm_name          = "${var.namespace}-alarm-networkpacketsin"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "4"
  metric_name         = "NetworkPacketsIn"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "10"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.autoscaling_group.name
  }

  alarm_description = (
    "This alarm is triggered when number of network packets received is low."
  )
  alarm_actions = [aws_autoscaling_policy.stop_all_instances.arn]
}