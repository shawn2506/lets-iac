data "template_file" "init-script" {
  template = file("scripts/init.cfg")
  vars = {
    REGION = var.region
  }
}

data "template_file" "shell-script" {
  template = file("scripts/volumes.sh")
  vars = {
    DEVICE = var.ec2-device-name
  }
}

data "template_cloudinit_config" "cloudinit-example" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.init-script.rendered
  }

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.shell-script.rendered
  }
}

