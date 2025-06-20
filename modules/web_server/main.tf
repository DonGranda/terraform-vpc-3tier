resource "aws_instance" "web_server" {
  for_each = var.app_private_subnets_ids_map
  # This module creates web server instances in the specified private subnets
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = each.value
  vpc_security_group_ids = [var.app_security_group_id]


  tags = {
    Name        = "${var.project_name}-${var.environment}-web-${each.key}"
    Environment = var.environment
    Project     = var.project_name
    Tier        = "App"

  }
  lifecycle {
    create_before_destroy = true
  }


  #     user_data = base64encode(templatefile("${path.module}/user_data.sh", {
  #     project_name = var.project_name
  #     environment  = var.environment
  #   }))
}