variable "region" {
  default = "us-east-1"
}

variable "ami" {
  type = map(string)
  default = {
    us-east-1  = "ami-03fbd9bcb97e9cabb"
    ap-south-1 = "ami-07b1360b71c3716d8"
  }
}

variable "private-key-path" {
  default = "key"
}

variable "public-key-path" {
  default = "key.pub"
}

variable "username" {
  default = "devop"
}

variable "password" {
  default = "ABABABAB212121212ABABABA"
}
