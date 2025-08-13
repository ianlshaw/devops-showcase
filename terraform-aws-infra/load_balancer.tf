# load_balancer.tf

resource "aws_lb_listener" "lb-listener" {
  load_balancer_arn = aws_lb.alb-web-server-public.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_web_app.arn
  }
}

resource "aws_lb" "alb-web-server-public" {
  name               = "web-server-public"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_lb.id]
  subnets = [aws_subnet.public_one.id, aws_subnet.public_two.id]
}

resource "aws_lb_target_group" "tg_web_app" {
  name     = "tf-example-lb-tg"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}