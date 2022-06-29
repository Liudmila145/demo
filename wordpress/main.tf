terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "wordpress-vpc" {
  cidr_block           = "10.100.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = {
    Name = "wordpress-vpc"
  }
}

resource "aws_internet_gateway" "wordpress-gw" {
  vpc_id = aws_vpc.wordpress-vpc.id
}

resource "aws_route_table" "wordpress-route-table" {
  vpc_id = aws_vpc.wordpress-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wordpress-gw.id
  }
  tags = {
    Name = "route-table-public"
  }
}

resource "aws_subnet" "wordpress-subnet" {
  vpc_id                  = aws_vpc.wordpress-vpc.id
  cidr_block              = "10.100.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "wordpress-subnet-10-10-1-0"
    Tier = "Public"
  }
}

resource "aws_route_table_association" "subnet-association" {
  subnet_id      = aws_subnet.wordpress-subnet.id
  route_table_id = aws_route_table.wordpress-route-table.id
}

resource "aws_security_group" "wordpress-security-group" {
  name        = "wordpress-security-group"
  description = "wordpress-security-group"
  vpc_id      = aws_vpc.wordpress-vpc.id

  ingress {
    description = "http"
    from_port   = 0
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow rule for http"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "wordpress-server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.wordpress-subnet.id

  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update && sudo apt upgrade -y && sudo apt install -y ca-certificates curl gnupg lsb-release
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    sudo apt -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin

    sudo usermod -aG docker ubuntu

    docker network create test-network
    docker run -d mysql:8 --name wordpress-mysql --restart=unless-stopped --network=test-network -e MYSQL_ROOT_PASSWORD=wordpress -e MYSQL_DATABASE=wordpress -e MYSQL_USER=wordpress -e MYSQL_PASSWORD=wordpress
    docker run -d application --name application --restart=unless-stopped --network=test-network -p 80:80
  EOF

  vpc_security_group_ids = [
    aws_security_group.wordpress-security-group.id
  ]

  tags = {
    Name = "wordpress-server"
  }
}
