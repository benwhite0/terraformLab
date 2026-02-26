module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "${var.project}-${var.environment}-web-files"

  versioning = {
    enabled = true
  }
}