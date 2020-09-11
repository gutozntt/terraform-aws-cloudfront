resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  count = var.create_oai ? 1 : 0
  comment = var.oai_comment
}
