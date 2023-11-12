# create alb
resource "aws_lb" "main" {
  name = "my-application-load-balancer"

  # handle traffic from the internet
  internal = false

  load_balancer_type = "application"
  security_groups = [module.sg.ALBSG_id]
  subnets = [module.network.public_subnet_1_id, module.network.public_subnet_2_id]
}

# target group
resource "aws_lb_target_group" "main" {
  health_check {
    interval            = 25
    path                = "/"
    protocol            = "HTTP"
    timeout             = 8
    healthy_threshold   = 5
    unhealthy_threshold = 3

  }

  name     = "my-alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.network.vpc_id
}

# attach target group to ec2 instance
resource "aws_lb_target_group_attachment" "test1" {
  depends_on = [module.ec2.aws_instance.application_instance_1]
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = module.ec2.application_instance_1_id
  port             = 80
}

resource "aws_lb_target_group_attachment" "test2" {
  depends_on = [module.ec2.aws_instance.application_instance_2]
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = module.ec2.application_instance_2_id
  port             = 80
}

# target group listener
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}