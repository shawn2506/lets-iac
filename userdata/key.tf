resource "aws_key_pair" "keypair" {
  key_name   = "key"
  public_key = file(var.public-key-path)
}

