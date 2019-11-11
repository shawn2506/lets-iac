resource "aws_instance" "apex-demo" {
  ami           = var.ami[var.region]
  instance_type = "t2.micro"
  subnet_id = aws_subnet.apex-public-1.id
  vpc_security_group_ids = [aws_security_group.ssh-access.id]
  key_name          = aws_key_pair.keypair.key_name
  availability_zone = "us-east-1a"
  user_data = data.template_cloudinit_config.cloudinit-example.rendered
}

resource "aws_ebs_volume" "apex-volume-1" {
  availability_zone = "us-east-1a"
  size              = 10
  type              = "gp2"
  encrypted         = true
  tags = {
    Name = "additional 10GB volume"
  }
  depends_on = ["aws_internet_gateway.apex-vpc-gw"]
}

resource "aws_volume_attachment" "apex-volume-1-attachment" {
  device_name = var.ec2-device-name
  volume_id   = aws_ebs_volume.apex-volume-1.id
  instance_id = aws_instance.apex-demo.id
  depends_on = ["aws_internet_gateway.apex-vpc-gw"]

}
