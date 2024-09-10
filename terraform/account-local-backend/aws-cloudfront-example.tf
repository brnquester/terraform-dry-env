# aws-cloudfront-example.tf

resource "aws_cloudfront_distribution" "example" {
  
  origin {
    domain_name = local.environment == "production" ? "www.test-website.com" : "stage.test-website.com"
    origin_id   = "example-origin"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront Distribution for ${local.environment}"
  default_root_object = "index.html"
  http_version        = "http2and3"

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "example-origin"
    viewer_protocol_policy = "redirect-to-https"

    response_headers_policy_id = "example-response-headers-policy-id"

    cache_policy_id          = "example-cache-policy-id"
    origin_request_policy_id = "example-origin-request-policy-id"

    dynamic "lambda_function_association" {
      # Only attach the Lambda@Edge function for non-production environments
      for_each = local.environment == "production" ? [] : [1]
      content {
        event_type   = "viewer-request"
        lambda_arn   = "example-lambda-arn"
        include_body = false
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    Environment = "${local.environment}"
  }
}