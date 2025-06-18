resource "aws_instance" "nginx_server" {
  ami                         = "ami-0f535a71b34f2d44a" # Example AMI ID, replace with a valid one
  instance_type               = "t2.micro"              # Example instance type, can be changed as needed
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.nginx_group.id]
  associate_public_ip_address = true



  tags = {
    Name = "Nginx_Server"
  }

  user_data = <<-EOF
              #!/bin/bash
              set -e
              set -x
              set -o 
                sudo dnf update -y
                sudo dnf install nginx -y
                sudo systemctl enable nginx
                sudo systemctl start nginx
                echo '<html><body><h1>Hello from Nginx on AWS EC2!</h1></body></html>' | sudo tee /usr/share/nginx/html/index.html
                sudo systemctl restart nginx
              EOF

}


