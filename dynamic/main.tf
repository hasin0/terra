provider "aws" {
  
  region = "us-east-2"
}

variable "ingressrules" {
  type = list(number)
  default = [ 80,443 ]
}


variable "iegressrules" {
  type = list(number)
  default = [ 80,443,25,3306,8080]
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

   dynamic "ingress" {
    iterator = port
    for_each = var.ingressrules
    content {

    from_port   = port.value
    to_port     = port.value
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
      
    }
   
  }



 dynamic "egress" {
    iterator = port
    for_each = var.iegressrules
    content {

    from_port   = port.value
    to_port     = port.value
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
      
    }
   
  }
  

  tags = {
    Name = "web-TR-sg"
  }
}




