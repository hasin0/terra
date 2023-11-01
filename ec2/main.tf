provider "aws" {
  
  region = "us-east-2"
}

resource "aws_instance" "ec2" {

    count = 3
    ami = "ami-024e6efaf93d85776"
    instance_type = "t2.micro"
    key_name = data.aws_key_pair.devopsproject.key_name
    security_groups = [aws_security_group.ansible.name]


      # Attach the security group to the instances
  #  vpc_security_group_ids = [aws_security_group.aws_security_group.ansible.i]


     tags = {
    Name = "ansible projects ${count.index + 1}"
  }
  
}

data "aws_key_pair" "devopsproject" {

 key_name   = "devopsproject"
#  public_key = file("/home/hassan/Downloads/devopsproject.pem") # Path to your public key file
  
}



variable "ingress" {
  type = list(number)
  default = [22, 80, 443]
}


variable "egress" {
  type = list(number)
  default = [22, 80, 443]
}

resource "aws_security_group" "ansible" {

    name = "ansibleSG"

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

