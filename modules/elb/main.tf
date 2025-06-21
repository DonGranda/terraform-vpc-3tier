resource "aws_lb" "web_elb" {
  name               = "${var.project_name}-${var.environment}-elb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.web_security_group_id]
  subnets            = values(var.public_subnet_ids)

  enable_deletion_protection = false

  tags = {
    Name        = "${var.project_name}-${var.environment}-elb"
    Environment = var.environment
    Project     = var.project_name
  }

}

resource "aws_lb_target_group" "web_elb_target_group" {
  name     = "${var.project_name}-${var.environment}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/health"
    matcher             = "200"
    port                = "traffic-port"
    protocol            = "HTTP"
  }

}

resource "aws_lb_listener" "web_elb_listener" {
  load_balancer_arn = aws_lb.web_elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_elb_target_group.arn
  }
}


resource "aws_lb_target_group_attachment" "web_servers" {
  for_each         = var.instance_ids
  target_group_arn = aws_lb_target_group.web_elb_target_group.arn
  target_id        = each.value
  port             = 80
}