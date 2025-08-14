# devops-showcase

My name is Ian Shaw


This project demonstrates a highly available web application deployed to AWS using terraform.
- Load balancer
- Auto scaling group

![title](asg.png)

### How to run it
- Configure AWS CLI with `aws configure`
- change directory to packer
- run `packer build`
- change directory to terraform-aws-infra
- run `terraform init`
- run `terraform plan -out=planfile`
- run `terraform apply planfile`

- Copy loadbalancer_public_dns from the output into the address bar of your browser.
- Press return

You will see "Hello, World!".

This is a flask web application running a minimal configuration. Prepared using packer here.

The application runs on ec2 instances, which uses an AMI created by packer.

The ec2 instances are part of an autoscaling group, which is configured to deploy to two private subnets.

The load balancer is associated with two public subnets.

Those two public subnets are associated with a route table which contains a route which allows communication to the internet via an internet gateway.

There is a route table which enables communication between the private and public subnets.

Application traffic is not set over the internet.

Application traffic flows on port 5000 from the ec2 instances to the load balancer only.

This is enforced by security group rules.

### TODO
network ACL restrict private subnet traffic to application traffic from load balancer