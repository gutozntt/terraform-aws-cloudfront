resource "aws_cloudfront_distribution" "cdf" {
  aliases             = var.aliases
  comment             = var.comment
  default_root_object = var.default_root_object
  enabled             = var.enabled
  is_ipv6_enabled     = var.is_ipv6_enabled
  http_version        = var.http_version
  price_class         = var.price_class
  tags                = var.tags
  web_acl_id          = var.web_acl_id
  retain_on_delete    = var.retain_on_delete
  wait_for_deployment = var.wait_for_deployment

  default_cache_behavior {
    allowed_methods           = var.allowed_methods
    cached_methods            = var.cached_methods
    compress                  = var.compress
    default_ttl               = var.default_ttl
    field_level_encryption_id = var.field_level_encryption_id
    max_ttl                   = var.max_ttl
    min_ttl                   = var.min_ttl
    smooth_streaming          = var.smooth_streaming
    target_origin_id          = var.target_origin_id
    trusted_signers           = var.trusted_signers
    viewer_protocol_policy    = var.viewer_protocol_policy

    forwarded_values {
      cookies {
        forward           = var.forward
        whitelisted_names = var.whitelisted_names
      }
      headers                 = var.headers
      query_string            = var.query_string
      query_string_cache_keys = var.query_string_cache_keys
    }
  }

  dynamic "ordered_cache_behavior" {
    for_each = var.ordered_cache_behavior
    content {
      allowed_methods           = ordered_cache_behavior.value["allowed_methods"]
      cached_methods            = ordered_cache_behavior.value["cached_methods"]
      compress                  = lookup(ordered_cache_behavior.value, "compress", null)
      default_ttl               = lookup(ordered_cache_behavior.value, "default_ttl", null)
      field_level_encryption_id = lookup(ordered_cache_behavior.value, "field_level_encryption_id", null)
      max_ttl                   = lookup(ordered_cache_behavior.value, "max_ttl", null)
      min_ttl                   = lookup(ordered_cache_behavior.value, "min_ttl", null)
      path_pattern              = ordered_cache_behavior.value["path_pattern"]
      smooth_streaming          = lookup(ordered_cache_behavior.value, "smooth_streaming", null)
      target_origin_id          = ordered_cache_behavior.value["target_origin_id"]
      trusted_signers           = lookup(ordered_cache_behavior.value, "trusted_signers", null)
      viewer_protocol_policy    = ordered_cache_behavior.value["viewer_protocol_policy"]
      forwarded_values {
        cookies {
          forward           = ordered_cache_behavior.value["forward"]
          whitelisted_names = lookup(ordered_cache_behavior.value, "whitelisted_names", null)
        }
        headers                 = lookup(ordered_cache_behavior.value, "headers", null)
        query_string            = ordered_cache_behavior.value["query_string"]
        query_string_cache_keys = lookup(ordered_cache_behavior.value, "query_string_cache_keys", null)
      }
    }
  }

  dynamic "logging_config" {
    for_each = var.logging_config
    content {
      bucket          = lookup(logging_config.value, "bucket", null)
      include_cookies = lookup(logging_config.value, "include_cookies", null)
      prefix          = lookup(logging_config.value, "prefix", null)
    }
  }

  dynamic "origin" {
    for_each = var.s3_origins
    content {
      domain_name              = lookup(origin.value, "domain_name", null)
      origin_id                = lookup(origin.value, "origin_id", null)
      origin_path              = lookup(origin.value, "origin_path", null)
      origin_access_control_id = lookup(origin.value, "origin_access_control_id", )
    }
  }

  dynamic "origin" {
    for_each = var.s3_origins_oai
    content {
      domain_name = lookup(origin.value, "domain_name", null)
      origin_id   = lookup(origin.value, "origin_id", null)
      origin_path = lookup(origin.value, "origin_path", null)

      s3_origin_config {
        origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity[0].cloudfront_access_identity_path
      }
    }
  }

  dynamic "origin" {
    for_each = var.custom_origins
    content {
      domain_name = lookup(origin.value, "domain_name", null)
      origin_id   = lookup(origin.value, "origin_id", null)
      origin_path = lookup(origin.value, "origin_path", null)
      custom_origin_config {
        http_port                = lookup(origin.value, "http_port", null)
        https_port               = lookup(origin.value, "https_port", null)
        origin_protocol_policy   = lookup(origin.value, "origin_protocol_policy", null)
        origin_ssl_protocols     = lookup(origin.value, "origin_ssl_protocols", null)
        origin_keepalive_timeout = lookup(origin.value, "origin_keepalive_timeout", null)
        origin_read_timeout      = lookup(origin.value, "origin_read_timeout", null)
      }
    }
  }

  viewer_certificate {
    acm_certificate_arn            = var.acm_certificate_arn
    cloudfront_default_certificate = var.cloudfront_default_certificate
    iam_certificate_id             = var.iam_certificate_id
    minimum_protocol_version       = var.cloudfront_default_certificate ? null : var.minimum_protocol_version
    ssl_support_method             = var.cloudfront_default_certificate ? null : var.ssl_support_method
  }

  restrictions {
    geo_restriction {
      restriction_type = var.restriction_type
      locations        = var.restriction_locations
    }
  }

  dynamic "custom_error_response" {
    for_each = var.custom_error_response
    content {
      error_caching_min_ttl = lookup(custom_error_response.value, "error_caching_min_ttl", null)
      error_code            = custom_error_response.value["error_code"]
      response_code         = lookup(custom_error_response.value, "response_code", null)
      response_page_path    = lookup(custom_error_response.value, "response_page_path", null)
    }
  }
}
