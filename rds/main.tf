provider "aws" {
  
  region = "us-east-2"
}


resource "aws_db_instance" "myrds" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  db_name              = "mydb"
  username             = "example"
  password             = "yourpassword"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}