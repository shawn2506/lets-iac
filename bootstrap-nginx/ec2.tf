resource "aws_key_pair" "key-pair" {
  key_name   = "key"
  public_key = file(var.public-key-path)
}

resource "aws_instance" "web-server" {
  ami           = var.ami[var.region]
  instance_type = "t2.micro"
  key_name      = aws_key_pair.key-pair.key_name

  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = ["chmod +x /tmp/script.sh", "sudo /tmp/script.sh",]
  }

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.username
    private_key = file(var.private-key-path)
  }
}
