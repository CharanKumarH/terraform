output "installed_nginx_server_ip" {
  value = aws_instance.nginx_server.public_ip
  description = "The public IP address of the installed Nginx server on AWS EC2."
  
}

output "instaceurl" {
  value = "http://${aws_instance.nginx_server.public_ip}"
  description = "The URL to access the Nginx server."
  
}