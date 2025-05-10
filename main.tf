provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "vps" {
  ami           = "ami-0c02fb55956c7d316"  # AMI Amazon Linux 2
  instance_type = "t2.micro"

  tags = {
    Name = "VPS-Terraform"
  }
}
# VPC
resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "MainVPC"
  }
}

# Sous-réseau public
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet"
  }
}

# Sous-réseau privé
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "PrivateSubnet"
  }
}

# Filtre de métrique pour surveiller les erreurs AccessDenied et SignatureDoesNotMatch
resource "aws_cloudwatch_log_metric_filter" "access_denied_filter" {
  name           = "AccessDeniedFilter"
  log_group_name = "/aws/cloudtrail/VPS" # ← remplace ce nom par celui utilisé par ton trail

  pattern = "{ ($.errorCode = \"AccessDenied\") || ($.errorCode = \"SignatureDoesNotMatch\") }"

  metric_transformation {
    name      = "AccessDeniedCount"
    namespace = "CloudTrailSecurity"
    value     = "1"
  }
}
# créer une alarme CloudWatch basée sur cette métrique
resource "aws_cloudwatch_metric_alarm" "access_denied_alarm" {
  alarm_name          = "AccessDeniedAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "AccessDeniedCount"
  namespace           = "CloudTrailSecurity"
  period              = 300
  statistic           = "Sum"
  threshold           = 1
  alarm_description   = "Détecte les erreurs AccessDenied ou SignatureDoesNotMatch"

  alarm_actions = [aws_sns_topic.alerts.arn]  # SNS pour envoyer les alertes
}
resource "aws_sns_topic" "alerts" {
  name = "cloudtrail-security-alerts"
}
#Créer un topic SNS pour recevoir les alertes
resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = "isseu940@gmail.com"  # à remplacer
}

