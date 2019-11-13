resource "aws_instance" "apex-demo" {
  ami           = var.ami[var.region]
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = aws_subnet.apex-public-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.ssh-access.id]

  # the public SSH key
  key_name = aws_key_pair.keypair.key_name
}

