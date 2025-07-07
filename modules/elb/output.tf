output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.web_elb.dns_name
}

# ALB ARN - useful for other AWS services integration
output "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  value       = aws_lb.web_elb.arn
}

# ALB Zone ID - needed for Route 53 alias records
output "alb_zone_id" {
  description = "The canonical hosted zone ID of the Application Load Balancer"
  value       = aws_lb.web_elb.zone_id
}

# Target Group ARN - useful for auto scaling group attachments
output "target_group_arn" {
  description = "The ARN of the Target Group"
  value       = aws_lb_target_group.web_elb_target_group.arn
}

output "target_group_id" {
  description = "The ID of the Target Group"
  value       = aws_lb_target_group.web_elb_target_group.id
}


output "target_group_arn_suffix" {
  description = "The suffix of the Target Group ARN for target tracking"
  value       = aws_lb_target_group.web_elb_target_group.arn_suffix
}

output "alb_arn_suffix" {
  description = "The suffix of the Application Load Balancer ARN for target tracking"
  value       = aws_lb.web_elb.arn_suffix

}

# Target Group Name
output "target_group_name" {
  description = "The name of the Target Group"
  value       = aws_lb_target_group.web_elb_target_group.name
}


output "alb_url" {
  description = "The complete URL of the Application Load Balancer"
  value       = "http://${aws_lb.web_elb.dns_name}"
}