resource "aws_s3_bucket" "demos3" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_acl" "demos3_acl" {
  bucket = aws_s3_bucket.demos3.id
  acl    = var.acl_value
}

resource "aws_s3_bucket_object" "demos3_object" {
  for_each = fileset("./website/", "**")
  bucket   = aws_s3_bucket.demos3.bucket
  key      = each.value
  source   = "./website/${each.value}"
  etag     = filemd5("./website/${each.value}")
}