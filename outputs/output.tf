output "public-ip" {
  value = aws_instance.demo-instance.public_ip
}

output "private-ip" {
  value = aws_instance.demo-instance.private_ip
}
