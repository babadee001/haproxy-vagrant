provider "aws" {
  region = "us-east-1"
}


variable "username" {
  default = "master"
}

variable "password" {
  default = "********"
}


resource "aws_instance" "Master"
 {
  ami = "ami-051f75c6"
  instance_type = "t2.micro"
  key_name="Key-pair"
}

resource "aws_instance" "Slave-1"
 {
  ami = "ami-051f75c6"
  instance_type = "t2.micro"
  key_name="Key-pair"
}

resource "aws_instance" "Slave-2"
 {
  ami = "ami-051f75c6"
  instance_type = "t2.micro"
  key_name="Key-pair"
}

resource "aws_security_group" "mysql-cluster" {
  name   = "mysql-SG"
  vpc_id = "${aws_default_vpc.default.id}"

  ingress {
    protocol    = "tcp"
    from_port   = 3306
    to_port     = 3306
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "tcp"
    from_port   = 8080
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0 
    to_port     = 0 
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_default_vpc" "default" {}
