resource "aws_key_pair" "key-pair" {
  key_name   = "key"
  public_key = file(var.public-key-path)
}

resource "aws_instance" "demo-windows" {
  ami           = var.ami[var.region]
  instance_type = "t2.micro"
  key_name      = aws_key_pair.key-pair.key_name
  user_data     = <<EOF
<powershell>
net user ${var.username} '${var.password}' /add /y
net localgroup administrators ${var.username} /add

winrm quickconfig -q
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="300"}'
winrm set winrm/config '@{MaxTimeoutms="1800000"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'

netsh advfirewall firewall add rule name="WinRM 5985" protocol=TCP dir=in localport=5985 action=allow
netsh advfirewall firewall add rule name="WinRM 5986" protocol=TCP dir=in localport=5986 action=allow

net stop winrm
sc.exe config winrm start=auto
net start winrm
</powershell>
EOF

  provisioner "file" {
    source      = "test.txt"
    destination = "C:/test.txt"
  }
  connection {
    host     = coalesce(self.public_ip, self.private_ip)
    type     = "winrm"
    timeout  = "10m"
    user     = var.username
    password = var.password
  }
}
