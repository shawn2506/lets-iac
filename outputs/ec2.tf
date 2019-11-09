resource "aws_instance" "demo-instance" {
  ami           = var.ami[var.region]
  instance_type = "t2.micro"
  provisioner "local-exec" {
    command = "echo ${aws_instance.demo-instance.private_ip} >> private_ips.txt"
  }
}
