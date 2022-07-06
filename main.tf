provider "aws" {
region = "us-east-2"
}

resource "aws_instance" "example" {

ami = "ami-00978328f54e31526"
instance_type = "t2.micro"
user_data = <<-EOF
            #!/bin/bash
            echo "Hey My Ammukutty" >index.html
            nohup busybox httpd -f -p 8080 &
            EOF
vpc_security_group_ids = [aws_security_group.instance.id]
tags= {
Name = "terraform-project"
}
}

resource "aws_security_group" "instance" {
name = "terraform-example"
ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

 
}
