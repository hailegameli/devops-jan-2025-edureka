terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.86.0"
    }
  }
}

//create vpc
resource "aws_vpc" "thanos-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "thanos-vpc"
  }
}

//create subnet1
resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.thanos-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "subnet1"
  }
}


//create subnet2
resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.thanos-vpc.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1a"

  tags = {
    Name = "subnet2"
  }
}

//create ec2 instance
resource "aws_instance" "thanos-server" {
  ami                     = "ami-00bb6a80f01f03502"
  instance_type           = "t2.micro"
  subnet_id = aws_subnet.subnet2.id

  tags = {
    Name = "thanos-server"
  }
}
