variable "region" {
  default = "us-east-1"
}

variable "ami" {
  type = map(string)
  default = {
    us-east-1  = "ami-04b9e92b5572fa0d1"
    ap-south-1 = "ami-0123b531fc646552f "
  }
}

variable "private-key-path" {
  default = "key"
}

variable "public-key-path" {
  default = "key.pub"
}

variable "username" {
  default = "ubuntu"
}
