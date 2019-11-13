output "instance-ip" {
  value = aws_instance.apex-demo.public_ip
}

output "instance-id" {
  value = aws_instance.apex-demo.id
}

output "rds-instance-id" {
  value = aws_db_instance.mariadb.id
}

output "vpc" {
  value = aws_vpc.apex-vpc.id
}

output "key-pair" {
  value = aws_key_pair.keypair.id
}

