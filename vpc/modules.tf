module "consul" {
  source = "../../modules/tf-consul-module"
  #  source   = "github.com/wardviaene/terraform-consul-module.git?ref=terraform-0.12"
  key_name = aws_key_pair.key.key_name
  key_path = var.private-key-path
  region   = var.region
  vpc_id   = aws_default_vpc.default.id
  subnets = {
    "0" = aws_default_subnet.default-az-1.id
    "1" = aws_default_subnet.default-az-2.id
    "2" = aws_default_subnet.default-az-3.id
  }
}

output "consul-output" {
  value = module.consul.server_address
}

