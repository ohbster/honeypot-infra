output "security_groups" {
  #value = aws_lb.lb.security_groups
  value = [
    for sg in aws_lb.lb.security_groups : sg
  ]
}
output "target_groups" {
  value = aws_lb_target_group.alb_tg.id
}
# output "security_groups" {
#     value = module.lb_sg.security_group_id
# }

# output "public_ip" {

# }
output "dns_name" {
  value = aws_lb.lb.dns_name
}

output "arn" {
  value = aws_lb.lb.arn
}