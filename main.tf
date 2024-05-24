provider "aws"{
    region="us-east-1"
    
    }

resource "aws_instance" "lws01" {
    ami = "ami-04b70fa74e45c3917"
    instance_type = "t2.micro"

user_data = <<-EOF

    #!/bin/bash
    echo "Hello, World" > index.xhtml
    nohup busybox httpd -f -p 8080 &
    EOF

user_data_replace_on_change = true

tags = {
  Name = "single web server aws"
}
}

