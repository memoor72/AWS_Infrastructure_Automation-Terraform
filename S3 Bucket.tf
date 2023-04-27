#module "s3_bucket_for_logs" {
  #source = "terraform-aws-modules/s3-bucket/aws"

  #bucket = "my-s3-bucket-for-logs-72"

  # Allow deletion of non-empty bucket
  #force_destroy = true

  #attach_elb_log_delivery_policy = true  # Required for ALB logs
  ##}
