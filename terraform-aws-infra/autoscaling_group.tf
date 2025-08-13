# autoscaling_group.tf

resource "aws_launch_template" "web-server-launch-template" {
  name          = "web-server"
  image_id      = data.aws_ami.simple-web-app.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [ aws_security_group.sg_ec2.id ]
}

resource "aws_autoscaling_group" "web-server-autoscaling-group" {
  desired_capacity   = 2
  max_size           = 5
  min_size           = 2
  target_group_arns = [aws_lb_target_group.tg_web_app.arn]
  vpc_zone_identifier = [aws_subnet.private_one.id, aws_subnet.private_two.id]

  launch_template {
    id      = aws_launch_template.web-server-launch-template.id
    version = "$Latest"
  }
}