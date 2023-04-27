output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

#output "key_pair_id" {
 # description = "The key pair ID"
  #value       = module.key_pair.key_pair_id
#}

output "vote_service_sg_id" {
  value = module.vote_service_sg.security_group_id
}

output "devproELB_sg_id" {
  value = module.devproELB_sg.security_group_id
}

output "ec2_instance_ids" {
  description = "The IDs of the EC2 instances created by the module"
  value       = { for k, v in module.ec2_instance : k => v.id }
}

output "ec2_instance_private_ips" {
  description = "The private IPs of the EC2 instances created by the module"
  value       = { for k, v in module.ec2_instance : k => v.private_ip }
}

output "ec2_instance_public_ips" {
  description = "The public IPs of the EC2 instances created by the module (if any)"
  value       = { for k, v in module.ec2_instance : k => v.public_ip }
}

output "key_pair_name" {
  description = "The key pair name"
  value       = module.key_pair.key_pair_name
}

output "s3_bucket_id" {
  description = "The name of the bucket."
  value       = aws_s3_bucket.alb_logs.id
}