# outputs.tf
  
output "loadbalancer_public_dns" {
  value = aws_lb.alb-web-server-public.dns_name
}