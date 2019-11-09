resource "aws_instance" "demo" {
  ami           = var.ami[var.region]
  instance_type = "t2.micro"
}
