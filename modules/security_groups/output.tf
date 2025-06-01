output "web_security_group_id" {
  description = "The ID of the web security group"
  value       = aws_security_group.web_sg.id
  
}

output "app_security_group_id" {
  description = "The ID of the app security group"
  value       = aws_security_group.app_sg.id
}
output "db_security_group_id" {
  description = "The ID of the database security group"
  value       = aws_security_group.db_sg.id
  
}

output "security_group_ids" {
  description = "A map of security group names to their IDs"
  value = {
    web_sg = aws_security_group.web_sg.id
    app_sg = aws_security_group.app_sg.id
    db_sg  = aws_security_group.db_sg.id
  } 
}