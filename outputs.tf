output "id" {
  value = aws_cloudfront_distribution.cdf.id
  description = "The identifier for the distribution."
}

output "arn" {
  value = aws_cloudfront_distribution.cdf.arn
  description = "The ARN (Amazon Resource Name) for the distribution."
}

output "domain_name" {
  value = aws_cloudfront_distribution.cdf.domain_name
  description = "The domain name corresponding to the distribution."
}
