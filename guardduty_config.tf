resource "aws_guardduty_detector" "main" {
  enable = true
}

resource "aws_config_configuration_recorder" "main" {
  name     = "default"
  role_arn = aws_iam_role.config_role.arn
}

resource "aws_config_delivery_channel" "main" {
  name           = "default"
  s3_bucket_name = aws_s3_bucket.trail_logs.id
}

resource "aws_config_configuration_recorder_status" "main" {
  name    = aws_config_configuration_recorder.main.name
  is_enabled = true
}
