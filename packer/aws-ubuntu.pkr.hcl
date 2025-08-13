packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
    git = {
      version = ">= 0.6.2"
      source  = "github.com/ethanmdavidson/git"
    }
  }
}

locals { 
  my_ami_name = "simple-web-app-${formatdate("YYYY-MM-DD-hhmmss", timestamp())}"
}

source "amazon-ebs" "ubuntu" {
  ami_name      = local.my_ami_name
  instance_type = "t2.micro"
  region        = "eu-west-2"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  name = "simple-web-app"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
  provisioner "shell" {
    inline = ["while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done"]
  }
  provisioner "shell" {
    inline = ["git clone https://github.com/ianlshaw/simple-web-app.git"]
  }
  provisioner "shell" {
    inline = ["sudo apt update"]
  }
  provisioner "shell" {
    inline = ["sudo apt install python3-pip -y"]
  }
  provisioner "shell" {
    inline = ["sudo apt install python3.10-venv -y"]
  }
  provisioner "shell" {
    inline = ["python3 -m venv .venv"]
  }
  provisioner "shell" {
    inline = [". .venv/bin/activate"]
  }
  provisioner "shell" {
    inline = ["pip install flask"]
  }
  provisioner "file" {
    source = "simple-web-app.service"
    destination = "/tmp/simple-web-app.service"
  }
  provisioner "shell" {
    inline = ["sudo mv /tmp/simple-web-app.service /etc/systemd/system/"]
  }
  provisioner "shell" {
    inline = ["sudo systemctl enable simple-web-app", "sudo systemctl start simple-web-app"]
  }
}