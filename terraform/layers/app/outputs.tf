output "terraformLab_lb_domain" {
  value = module.terraformLab_public_alb.lb_dns_name
}