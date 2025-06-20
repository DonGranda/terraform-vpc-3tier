output "instance_ids" {
  description = "Map of EC2 instance IDs"
  value       = { for k, v in aws_instance.web_servers : k => v.id }
}

output "instance_private_ips" {
  description = "Map of EC2 instance private IP addresses"
  value       = { for k, v in aws_instance.web_servers : k => v.private_ip }
}
