
provider "aws" {

 region = "us-east-2"
 
 }


 module "ec2module" {
    source = "./ec2"
    ec2name = "Name from module"
 }

 output "module_output" {
    value = module.ec2module.instance_id
   
 }
/* resource "aws_instance" "ec2" {
    ami = "ami-024e6efaf93d85776"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.web-TR.name]

     tags = {
    Name = "terraform-example-instance"
  }
  
} */