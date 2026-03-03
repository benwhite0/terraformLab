resource "aws_s3_object" "object" {
  bucket = data.aws_s3_bucket.web_files_bucket.id
  key    = "index.html"
  source = "../src/index.html"
}