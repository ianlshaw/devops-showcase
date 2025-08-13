# devops-showcase

My name is Ian Shaw


This project demonstrates a highly available web application deployed to AWS using terraform.
- Load balancer
- Auto scaling group

### How to run it
- Configure AWS CLI
`terraform init`
`terraform plan -out=planfile`
`terraform apply planfile`

- Copy loadbalancer_public_dns from the output into the address bar of your browser.
- Press return

You will see "Hello, World!".

This is a flask web application running a minimal configuration. Prepared using packer here.

The application runs on an ec2 instance, which uses an AMI created using packer.

The ec2 instance is part of an autoscaling group, which is configured to deploy to two private subnets.

The load balancer is associated with two public subnets.

Those two public subnets are associated with a route table which contains a route which allows communication to the internet via an internet gateway.

Application traffic is not set over the internet.

Application traffic flows on port 5000 from the ec2 instances to the load balancer only.

This is enforced by security group rules.

### TODO
network ACL restrict private subnet traffic to application traffic from load balancer