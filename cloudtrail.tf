resource "aws_s3_bucket" "trail_logs" {
  bucket = "cloudtrail-logs-bucket-example"
}

resource "aws_cloudtrail" "main" {
  name                          = "global-trail"
  s3_bucket_name                = aws_s3_bucket.trail_logs.id
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  cloud_watch_logs_group_arn    = aws_cloudwatch_log_group.trail.arn
  cloud_watch_logs_role_arn     = aws_iam_role.cloudtrail_role.arn
}

resource "aws_cloudwatch_log_group" "trail" {
  name = "cloudtrail-logs"
}
