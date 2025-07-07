resource "aws_autoscaling_group" "app-server-asg" {
  name                = "${var.project_name}-${var.environment}-web-asg"
  vpc_zone_identifier = values(var.app_private_subnets_ids_map)
  #thi
  target_group_arns         = [var.target_group_arn]
  health_check_type         = "ELB"
  health_check_grace_period = 300
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity

  launch_template {
    id      = aws_launch_template.app_server-template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.project_name}-${var.environment}-web-asg"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = var.project_name
    propagate_at_launch = true
  }

  tag {
    key                 = "Tier"
    value               = "App"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

# ===================Auto Scaling Policy========================

# Scale up and down based on the average CPU utilization of the instances in the Auto Scaling Group.
resource "aws_autoscaling_policy" "cpu_target_tracking" {
  name                   = "${var.project_name}-${var.environment}-target-tracking-policy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.app-server-asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value     = 70
    disable_scale_in = false
  }

  estimated_instance_warmup = 300
}

resource "aws_autoscaling_policy" "alb_request_count_target_tracking" {
  # This allows the policy to be created only if enable_alb_target_tracking is true
  count = var.enable_alb_target_tracking ? 1 : 0

  name = "${var.project_name}-${var.environment}-alb-request-target-tracking"
  autoscaling_group_name = aws_autoscaling_group.app-server-asg.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = "${var.alb_arn_suffix}/${var.target_group_arn_suffix}"
    }
    target_value = 1000.0
  }

  estimated_instance_warmup = 300
}

# ================================SNS Notification================================
resource "aws_sns_topic" "alarm_notifications" {
  name = "${var.project_name}-${var.environment}-scaling-notify-topic"
}

resource "aws_autoscaling_notification" "asg_notifications" {
  group_names = [aws_autoscaling_group.app-server-asg.name]
  topic_arn   = aws_sns_topic.alarm_notifications.arn

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:TEST_NOTIFICATION"
  ]
}

resource "aws_sns_topic_subscription" "asg_email_subscription" {
  topic_arn = aws_sns_topic.alarm_notifications.arn
  protocol  = "email"
  endpoint  = var.notification_email
}


resource "aws_sns_topic_subscription" "asg_sms_subscription" {
  topic_arn = aws_sns_topic.alarm_notifications.arn
  protocol  = "sms"
  endpoint  = var.notification_sms_number
}

resource "aws_cloudwatch_metric_alarm" "cpu_high_notify" {
  alarm_name          = "${var.project_name}-${var.environment}-cpu-high-alert"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "Alert: EC2 CPU utilization high"
  alarm_actions       = [aws_sns_topic.alarm_notifications.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.app-server-asg.name
  }
}


resource "aws_cloudwatch_metric_alarm" "cpu_low_notify" {
  alarm_name          = "${var.project_name}-${var.environment}-cpu-low-alert"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 25
  alarm_description   = "Alert: EC2 CPU utilization low"
  alarm_actions       = [aws_sns_topic.alarm_notifications.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.app-server-asg.name
  }
}