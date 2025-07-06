resource "aws_autoscaling_group" "web-servers-ag" {
    name                = "${var.project_name}-${var.environment}-web-asg"
  vpc_zone_identifier = values(var.app_private_subnets_ids_map)
  #check this part rember to work on the targer group and sg and listener ports
 
  target_group_arns   = var.target_group_arn
  health_check_type   = "ELB"
  health_check_grace_period = 300
  
  min_size         = var.min_size
  max_size         = var.max_size
  # desired_capacity = var.desired_capacity
  
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

#Scale up and down based on the average CPU utilization of the instances in the Auto Scaling Group.
resource "aws_autoscaling_policy" "cpu_target_tracking" {
  name                   = "${var.project_name}-${var.environment}-target-tracking-policy"
  policy_type = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.web-servers-ag.name

target_tracking_configuration {
  predefined_metric_specification {
    predefined_metric_type = "ASGAverageCPUUtilization"
  }
  target_value = 80
  disable_scale_in = false

}

  estimated_instance_warmup = 300
}


resource "aws_autoscaling_policy" "alb_request_count_target_tracking" {
  # This allows the policy to be created only if enable_alb_target_tracking is true
  count = var.enable_alb_target_tracking ? 1 : 0
  
  name               = "${var.project_name}-${var.environment}-alb-request-target-tracking"
  autoscaling_group_name = aws_autoscaling_group.web_servers.name
  policy_type        = "TargetTrackingScaling"
  
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = "${var.alb_arn_suffix}/${var.target_group_arn_suffix}"
    }
    target_value = 1000.0
    
  }
    estimated_instance_warmup = 300

}

# ================================SNS Notifation================================
