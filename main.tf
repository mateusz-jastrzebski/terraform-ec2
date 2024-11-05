terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

provider "cloudflare" {

  api_token = var.cloudflare_api_token
}

resource "aws_security_group" "app_sg" {
  name_prefix = "app-sg-"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app_server" {
  ami           = "ami-08eb150f611ca277f"
  instance_type = "t3.micro"
  key_name      = var.key_name
  security_groups = [aws_security_group.app_sg.name]

  user_data = <<-EOF
            #!/bin/bash
            apt-get update
            apt-get install -y nginx
            echo "<html><head><meta charset='UTF-8'></head><body><h1>${var.user_name}</h1></body></html>" > /var/www/html/index.html
            systemctl start nginx
            systemctl enable nginx
            EOF


  tags = {
    Name = "Test-EC2"
  }
}

resource "cloudflare_record" "cloudflare_instance" {
  zone_id = var.cloudflare_zone_id
  name    = "ec2-test" 
  value   = aws_instance.app_server.public_ip
  type    = "A"
  proxied = "1"
  ttl     = 1
}

output "app_server_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}
