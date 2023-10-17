provider "aws" {
  
  region = "us-east-2"
}

resource "aws_instance" "ec2" {
    ami = "ami-024e6efaf93d85776"
    instance_type = "t2.micro"

     tags = {
    Name = "terraform-example-instance"
  }
  
}

output "public_ip" {
  value = aws_instance.ec2.public_ip
}

resource "aws_eip" "elasticip" {
  instance = aws_instance.ec2.id

  tags = {
    Name = "terraform-example-eip"
  }
}
/* 

output "elastic_ip" {
  value = aws_eip.elasticip.public_ip
} */

/* hjfdhfhjdfhfdh */