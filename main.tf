provider "aws"{
    region="us-east-1"
    
    }

variable "web_server_port" {
    description = "port used by the web server"
    type = number
    default = 8080
  
}

resource "aws_security_group" "web_server"{
    ingress {
        from_port = var.web_server_port
        to_port = var.web_server_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "lws01" {
    ami = "ami-04b70fa74e45c3917"
    instance_type = "t2.micro"
    vpc_security_group_ids = [ aws_security_group.web_server.id ]

user_data = <<-EOF

    #!/bin/bash
    echo "Hello, World" > index.xhtml
    nohup busybox httpd -f -p "${var.web_server_port}" &
    EOF

user_data_replace_on_change = true

tags = {
  Name = "single web server aws"
}


}

