resource "aws_autoscaling_group" "web-servers-ag" {
    name                = "${var.project_name}-${var.environment}-web-asg"
  vpc_zone_identifier = values(var.app_private_subnets_ids_map)
  target_group_arns   = var.target_group_arns
  health_check_type   = "ELB"
  health_check_grace_period = 300
  
  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity
  
  launch_template {
    id      = aws_launch_template.web_servers.id
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