
variable "ec2name" {
    type = string
    /* description = "(optional) describe your variable" */
}



resource "aws_instance" "ec2" {
    ami = "ami-024e6efaf93d85776"
    instance_type = "t2.micro"
    /* security_groups = [aws_security_group.web-TR.name] */

     tags = {
    Name = var.ec2name
  }
  
}

output "instance_id" {
    value = aws_instance.ec2.id

  
}