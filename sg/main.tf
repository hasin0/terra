provider "aws" {
  
  region = "us-east-2"
}

resource "aws_instance" "ec2" {
    ami = "ami-024e6efaf93d85776"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.web-TR.name]

     tags = {
    Name = "terraform-example-instance"
  }
  
}

resource "aws_security_group" "web-TR" {
  name        = "web-TR-sg"
  description = "Security group for web-TR"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }




  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  

  tags = {
    Name = "web-TR-sg"
  }
}




