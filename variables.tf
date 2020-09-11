variable "aliases" {
  description = "Extra CNAMEs (alternate domain names), if any, for this distribution."
  default = null
  type = list
}
variable "comment" {
  description = "Any comments you want to include about the distribution."
  default = null
}
variable "default_root_object" {
  description = "The object that you want CloudFront to return (for example, index.html) when an end user requests the root URL."
  default = null
}
variable "enabled" {
  description = "Whether the distribution is enabled to accept end user requests for content."
}
variable "is_ipv6_enabled" {
  description = "Whether the IPv6 is enabled for the distribution."
  default = null
}
variable "http_version" {
  description = "The maximum HTTP version to support on the distribution. Allowed values are http1.1 and http2. The default is http2."
  default = "http2"
}
variable "price_class" {
  description = "The price class for this distribution. One of PriceClass_All, PriceClass_200, PriceClass_100"
  default = "PriceClass_100"
}
variable "tags" {
  description = "A map of tags to assign to the resource."
  type = map
  default = null
}
variable "web_acl_id" {
  description = " If you're using AWS WAF to filter CloudFront requests, the Id of the AWS WAF web ACL that is associated with the distribution."
  default = null
}
variable "retain_on_delete" {
  description = "Disables the distribution instead of deleting it when destroying the resource through Terraform. If this is set, the distribution needs to be deleted manually afterwards."
  default     = "false"
}
variable "wait_for_deployment" {
  description = "If enabled, the resource will wait for the distribution status to change from InProgress to Deployed. Setting this tofalse will skip the process."
  default     = "true"
}
variable "allowed_methods" {
  description = "Controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin."
  type = list(string)
}
variable "cached_methods" {
  description = "Controls whether CloudFront caches the response to requests using the specified HTTP methods."
  type = list(string)
}
variable "compress" {
  description = "Whether you want CloudFront to automatically compress content for web requests that include Accept-Encoding: gzip in the request header (default: false)."
  default = "false"
}
variable "default_ttl" {
  description = "The default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of an Cache-Control max-age or Expires header."
  default = "86400"
}
variable "field_level_encryption_id" {
  description = "Field level encryption configuration ID"
  default     = null
}
variable "forward" {
  description = "Specifies whether you want CloudFront to forward cookies to the origin that is associated with this cache behavior."
}
variable "whitelisted_names" {
  default = null
  description = "If you have specified whitelist to forward, the whitelisted cookies that you want CloudFront to forward to your origin."
}
variable "headers" {
  description = "Specifies the Headers, if any, that you want CloudFront to vary upon for this cache behavior. Specify * to include all headers."
  default = null
}
variable "query_string" {
  description = "Indicates whether you want CloudFront to forward query strings to the origin that is associated with this cache behavior."
}
variable "query_string_cache_keys" {
  description = "When specified, along with a value of true for query_string, all query strings are forwarded, however only the query string keys listed in this argument are cached. When omitted with a value of true for query_string, all query string keys are cached."
  default = null
}
variable "max_ttl" {
  description = "The maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated."
  default = "31536000"
}
variable "min_ttl" {
  description = "The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated."
  default = "0"
}
variable "smooth_streaming" {
  description = "Indicates whether you want to distribute media files in Microsoft Smooth Streaming format using the origin that is associated with this cache behavior."
  default = null
}
variable "target_origin_id" {
  description = "The value of ID for the origin that you want CloudFront to route requests to when a request matches the path pattern either for a cache behavior or for the default cache behavior."
}
variable "trusted_signers" {
  description = "The AWS accounts, if any, that you want to allow to create signed URLs for private content."
  default = null
}
variable "viewer_protocol_policy" {
  description = "Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern. One of allow-all, https-only, or redirect-to-https."
}

variable "logging_config" {
  description = "A list of maps to describe S3 logging bucket"
  type = list(map(string))
  default = []
}

variable "s3_origins" {
  description = "A list of maps to describe S3 Origins"
  type = list(map(string))
  default = []
}
variable "s3_origins_oai" {
  description = "A list of maps to describe S3 Origins with Origin Access Identity"
  type = list(map(string))
  default = []
}
variable "custom_origins" {
  description = "A list of maps to describe Custom Origins"
  type = list(any)
  default = []
}
variable "restriction_type" {
  description = "The method that you want to use to restrict distribution of your content by country: none, whitelist, or blacklist."
  default = "none"
}
variable "restriction_locations" {
  description = "The ISO 3166-1-alpha-2 codes for which you want CloudFront either to distribute your content (whitelist) or not distribute your content (blacklist)."
  default = null
}

variable "acm_certificate_arn" {
  description = "The ARN of the AWS Certificate Manager certificate that you wish to use with this distribution."
  default = null
}
variable "cloudfront_default_certificate" {
  description = "true if you want viewers to use HTTPS to request your objects and you're using the CloudFront domain name for your distribution."
  default = "false"
}
variable "iam_certificate_id" {
  description = "The IAM certificate identifier of the custom viewer certificate for this distribution if you are using a custom domain."
  default = null
}
variable "minimum_protocol_version" {
  description = "The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections."
  default = "TLSv1"
}
variable "ssl_support_method" {
  description = "Specifies how you want CloudFront to serve HTTPS requests."
  default = null
}
variable "custom_error_response" {
  description = "List of maps of one or more custom error response elements (multiples allowed)."
  type = list(map(string))
  default = []
}
variable "create_oai" {
  description = "Whether you want to create Origin Access Identity"
  default = "false"
}
variable "oai_comment" {
  description = "Origin Access Identity Comment"
  default = null
}
variable "ordered_cache_behavior" {
  description = "An ordered list of cache behaviors resource for this distribution. List from top to bottom in order of precedence. The topmost cache behavior will have precedence 0."
  default = []
  type = list(any)
}
