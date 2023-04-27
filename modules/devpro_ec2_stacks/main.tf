resource "aws_security_group" "devpro-sg" {
  name        = "devpro-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      =  vpc_id

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [ var.my_ip]

  }

  ingress {
    description      = "TLS from internet"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env_prefix}-sg"
  }
}

data "aws_ami" "latest-amazon-linux-image" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "devpro_key_pair" {
  key_name   = "devpro-server-key-pair"
  public_key = file(var.public_key_location)
}

resource "aws_instance" "devpro-server" {
  ami                    = data.aws_ami.latest-amazon-linux-image.id
  instance_type          = var.instance_type
  subnet_id              = public_subnets
  vpc_security_group_ids = [aws_security_group.devpro-sg.id]
  availability_zone      = var.avail_zone

  associate_public_ip_address = true
  key_name = aws_key_pair.devpro_key_pair.key_name

  user_data = file("entry-script.sh")

  tags = {
    Name = "${var.env_prefix}-srv"
  }
}