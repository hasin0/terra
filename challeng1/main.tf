provider "aws" {
  
  region = "us-east-2"
}

resource "aws_instance" "webserver" {
    ami = "ami-024e6efaf93d85776"
    instance_type = "t2.micro"
    security_groups = [ aws_security_group.web_traffic.name ]
    user_data = file("server.sh")

     tags = {
    Name = "webserver 1"
  }
  
}


resource "aws_instance" "dbserver" {
    ami = "ami-024e6efaf93d85776"
    instance_type = "t2.micro"

     tags = {
    Name = "dbserver  1"
  }
  
}


resource "aws_eip" "elasticip" {
  instance = aws_instance.webserver.id

  tags = {
    Name = "eip"
  }
} 

variable "ingress" {
  type = list(number)
  default = [ 80,443 ]
}


variable "egress" {
  type = list(number)
  default = [ 80,443 ]
}

resource "aws_security_group" "web_traffic" {

    name = "allow web traffic"

    dynamic "ingress" {
        iterator = port
        for_each = var.ingress
        content {
          from_port = port.value
          to_port = port.value
          protocol = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
        }
      
    }





     dynamic "egress" {
        iterator = port
        for_each = var.egress
        content {
          from_port = port.value
          to_port = port.value
          protocol = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
        }
      
    }
  
}

output "privateIP" {
  value = aws_instance.dbserver.private_ip
}

output "publicIP" {
  value = aws_instance.webserver.public_ip
}