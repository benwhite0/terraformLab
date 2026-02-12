module "alb" {
  source = "terraform-aws-modules/alb/aws"

  name = "${var.project}-${var.environment}-alb"
  vpc_id = module.vpc.vpc_id
  subnets = module.vpc.public_subnets
  
 # Security Group
  security_group_ingress_rules = {
    all_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      description = "HTTP web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }

    all_https = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      description = "HTTPS web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }


  target_groups = [
    {
      name = "${var.project}-${var.environment}-alb-target-group"
      port = 80
      protocol = "HTTP"
    }
  ]
  }