
module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"
  key_name   = "devpro-stack-key"
  public_key = file(var.public_key_location)

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}