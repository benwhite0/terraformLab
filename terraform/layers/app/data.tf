data "aws_vpc" "terraformLab-vpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.project}-${var.environment}-vpc"]
  }
}

data "aws_subnets" "terraformLab-public-subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.terraformLab-vpc.id]
  }
  filter {
    name   = "tag:Name"
    values = ["${var.project}-${var.environment}-vpc-public-*"]
  }
}
     