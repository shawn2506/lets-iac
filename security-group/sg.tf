data "aws_ip_ranges" "america_ec2" {
  regions = ["us-east-1"]
  services = ["ec2"]
}

data "aws_ip_ranges" "india_ec2" {
  regions = ["ap-south-1"]
  services = ["ec2"]
}

resource "aws_security_group" "america-sg" {
  name = "america-sg"
  
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = data.aws_ip_ranges.america_ec2.cidr_blocks
  }
  tags = {
    CreateDate = data.aws_ip_ranges.america_ec2.create_date
    SyncToken  = data.aws_ip_ranges.america_ec2.sync_token
  }
}

resource "aws_security_group" "india-sg" {
  name = "india-sg"

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = data.aws_ip_ranges.india_ec2.cidr_blocks
  }
  tags = {
    CreateDate = data.aws_ip_ranges.india_ec2.create_date
    SyncToken  = data.aws_ip_ranges.india_ec2.sync_token
  }
}
