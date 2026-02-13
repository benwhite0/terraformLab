
resource "aws_security_group" "alb_sg" {
  name_prefix = "${var.project}-${var.environment}-alb-sg"
  description = "Security group for ALB ${var.project}-${var.environment}"
  vpc_id      = data.aws_vpc.terraformLab-vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "alb_http" {
  security_group_id = aws_security_group.alb_sg.id
  description       = "HTTP web traffic"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "alb_https" {
  security_group_id = aws_security_group.alb_sg.id
  description       = "HTTPS web traffic"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "alb_all" {
  security_group_id = aws_security_group.alb_sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

module "alb" {
  source = "terraform-aws-modules/alb/aws"

  name    = "${var.project}-${var.environment}-alb"
  vpc_id  = data.aws_vpc.terraformLab-vpc.id
  subnets = data.aws_subnets.terraformLab-public-subnets.ids

  security_groups = [aws_security_group.alb_sg.id]

  target_groups = [

    {
      name        = "${var.project}-${var.environment}-alb-target-group"
      port        = 80
      protocol    = "HTTP"
      target_type = "instance"
      health_check = {
        path                = "/"
        port                = 80
        unhealthy_threshold = 3
        interval            = 60
        matcher             = "200"
      }
    }
  ]

  listeners = {
    http = {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  }
}