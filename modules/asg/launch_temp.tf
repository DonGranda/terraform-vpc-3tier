# Launch Template for Auto Scaling Group
resource "aws_launch_template" "app_server-template" {
  name_prefix            = "${var.project_name}-${var.environment}-web-template-"
  image_id               = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.app_security_group_id]




  #user data 
  user_data = filebase64("${path.module}/webapp.sh")



  # Block device mapping for EBS volumes
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size           = var.root_volume_size
      volume_type           = var.root_volume_type
      encrypted             = var.ebs_encrypted
      delete_on_termination = true
    }
  }

  # Network interface configuration
  network_interfaces {
    delete_on_termination       = true
    device_index                = 0
    associate_public_ip_address = false
  }


  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "${var.project_name}-${var.environment}-web-asg"
      Environment = var.environment
      Project     = var.project_name
      Tier        = "App"
    }
  }


  tag_specifications {
    resource_type = "volume"
    tags = {
      Name        = "${var.project_name}-${var.environment}-web-asg-volume"
      Environment = var.environment
      Project     = var.project_name
      Tier        = "App"
    }
  }

  lifecycle {
    create_before_destroy = true
  }

}
