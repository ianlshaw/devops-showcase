data "aws_ami" "simple-web-app" {
  most_recent = true

  filter {
    name   = "name"
    values = ["simple-web-app*"]
  }

  owners = ["self"]
}