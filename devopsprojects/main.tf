provider "aws" {
  
  region = "us-east-2"
}


resource "aws_ebs_volume" "fordevops" {

  count = 2
  availability_zone = "us-east-2a"
  size              = 25

  tags = {
    Name = "devopsec project"
  }
}



resource "aws_volume_attachment" "ebs_att" {
  count = 2

  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.fordevops[count.index].id
  instance_id = aws_instance.ec2[count.index].id
}


resource "aws_instance" "ec2" {

    count = 2
    ami = "ami-0e83be366243f524a"
    instance_type = "t2.large"
    availability_zone = "us-east-2a"

    key_name = data.aws_key_pair.docker.key_name
    # availability_zone = "us-east-2"

    security_groups = [aws_security_group.ansible.name]
    
    


      # Attach the security group to the instances
  #  vpc_security_group_ids = [aws_security_group.aws_security_group.ansible.i]


     tags = {

      Name = "ec2 ${element(["netflix-jenkins", "monitoring"], count.index)}"

    # Name = "ansible projects ${count.index + 1}"
  }
  
}

data "aws_key_pair" "docker" {

 key_name   = "docker"
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
