resource "aws_instance" "apex-demo" {
  ami           = var.ami[var.region]
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = aws_subnet.apex-public-2.id

  # the security group
  vpc_security_group_ids = [aws_security_group.ssh-access.id]

  # the public SSH key
  key_name = aws_key_pair.keypair.key_name
}

resource "aws_ebs_volume" "apex-volume-1" {
  availability_zone = "us-east-1a"
  size              = 10
  type              = "gp2"
  encrypted         = true
  tags = {
    Name = "additional 10GB volume"
  }
}

resource "aws_volume_attachment" "apex-volume-1-attachment" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.apex-volume-1.id
  instance_id = aws_instance.apex-demo.id
}
