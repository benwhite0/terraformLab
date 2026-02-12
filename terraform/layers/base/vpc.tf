data "aws_availability_zones" "available" {}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 3)
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.project}-${var.environment}-vpc"
  cidr = var.vpc_cidr

  azs = local.azs

  private_subnets = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 3, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 3, length(local.azs) + k)]

  single_nat_gateway = true

}