resource "aws_cloudfront_cache_policy" "cloudfront_cache_policy" {
  name        = "cfcp-${var.region}-${var.environment}-${var.app}"
  min_ttl                = 0
  default_ttl            = 3600
  max_ttl                = 86400
  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }
    headers_config {
      header_behavior = "none"
    }
    query_strings_config {
      query_string_behavior = "none"
    }
  }
}

resource "aws_cloudfront_origin_access_control" "access_control" {
  name                              = aws_s3_bucket.bucket.bucket
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.bucket.bucket_domain_name
    origin_id                = aws_s3_bucket.bucket.bucket
    origin_access_control_id = aws_cloudfront_origin_access_control.access_control.id
  }

  aliases = [var.domain]

  enabled             = true
  is_ipv6_enabled     = true

  default_root_object = "/container/latest/index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.bucket.bucket
    cache_policy_id = aws_cloudfront_cache_policy.cloudfront_cache_policy.id

    viewer_protocol_policy = "redirect-to-https"
  }

  custom_error_response {
    error_code = 403
    response_page_path = "/container/latest/index.html"
    response_code = 200
    error_caching_min_ttl = 10
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.cert.arn
    ssl_support_method = "sni-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations = []
    }
  }

  tags = var.tags
}