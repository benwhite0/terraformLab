data "aws_vpc" "terraformLab_vpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.project}_${var.environment}_vpc"]
  }
}

data "aws_subnets" "terraformLab_public_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.terraformLab_vpc.id]
  }
  filter {
    name   = "tag:Name"
    values = ["${var.project}_${var.environment}_vpc_public_*"]
  }
}

data "aws_s3_bucket" "web_files_bucket" {
  bucket = "${var.project}-${var.environment}-web-files"
}
