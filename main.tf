provider "aws" {
  region = "us-east-2"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "devpro-vpc"
  cidr = var.vpc_cidr_block

  azs             = [var.avail_zone_1,var.avail_zone_2,var.avail_zone_3]
  private_subnets = [var.PrivSub1Cidr, var.PrivSub2Cidr,var.PrivSub3Cidr]
  public_subnets  = [var.PubSub1Cidr,var.PubSub2Cidr,var.PubSub3Cidr]
  private_subnet_tags = {
    "Name-1" = "${var.env_prefix}-prisubnet-1"
    "Name-2" = "${var.env_prefix}-prisubnet-2"
    "Name-3" = "${var.env_prefix}-prisubnet-3"
  }

  public_subnet_tags = {
    "Name-1" = "${var.env_prefix}-pubsubnet-1"
    "Name-2" = "${var.env_prefix}-pubsubnet-2"
    "Name-3" = "${var.env_prefix}-pubsubnet-3"
  }

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Name = "${var.env_prefix}-vpc"
    Terraform = "true"
    Environment = "dev"
  }
}

#resource "aws_key_pair" "devpro_stack_key" {
  #key_name   = "devpro-stack-key"
  #public_key = file(var.public_key_location)

  #tags = {
   # Terraform = "true"
   # Environment = "dev"
  #}
#}

resource "aws_s3_bucket" "alb_logs" {
  bucket = "my-alb-logs-memoor72"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

  resource "aws_s3_bucket_policy" "alb_logs_policy" {
  bucket = aws_s3_bucket.alb_logs.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          #"Service": "logdelivery.elasticloadbalancing.amazonaws.com"
          "AWS": "arn:aws:iam::033677994240:root"
        },
        "Action": [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:DeleteObject",
          "s3:GetBucketAcl",
          "s3:PutObject",
        ],
        "Resource": "arn:aws:s3:::my-alb-logs-memoor72/prefix/AWSLogs/062894342784/*"
        #"Resource": [
          #"arn:aws:s3:::my-alb-logs-memoor72/*",
         # "arn:aws:s3:::my-alb-logs-memoor72"
      }
    ]
  })
}

