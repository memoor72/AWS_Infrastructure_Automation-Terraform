module "vote_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "devpro-stack-sg"
  description = "Security group for devpro-stacks"
  vpc_id      = module.vpc.vpc_id
  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_rules            = []
  ingress_with_cidr_blocks = [
    # Nginx (HTTP and HTTPS)
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "Nginx HTTP"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "Nginx HTTPS"
      cidr_blocks = "0.0.0.0/0"
    },
    # Tomcat
    {
      from_port   = 8080
      to_port     = 8090
      protocol    = "tcp"
      description = "Tomcat"
      cidr_blocks = "0.0.0.0/0"
    },
    # Memcache
    {
      from_port   = 11211
      to_port     = 11211
      protocol    = "tcp"
      description = "Memcache"
      cidr_blocks = "0.0.0.0/0"
    },
    # RabbitMQ
    {
      from_port   = 5672
      to_port     = 5672
      protocol    = "tcp"
      description = "RabbitMQ"
      cidr_blocks = "0.0.0.0/0"
    },
    # MySQL
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQL"
      cidr_blocks = "0.0.0.0/0"
    },
     # SSH
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

# Create load balancer security group
module "devproELB_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "devproELB"
  description = "Security group for load balancer"
  vpc_id      = module.vpc.vpc_id
  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_rules            = []
  ingress_with_cidr_blocks = [

    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "elb HTTP"
      cidr_blocks = "0.0.0.0/0"

    }

  ]
}

