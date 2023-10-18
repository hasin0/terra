#!/bin/bash
sudo yum update
sudo yum install -y httpd
sudo yum systemctl start httpd
sudo yum systemctl enable httpd
echo"<h1>hello from terraform </h1>"| sudo tee /var/www/html/index.html


