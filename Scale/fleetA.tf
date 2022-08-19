resource "aws_security_group" "fleetAaccess" {
  name = "fleetAaccess"
  vpc_id = var.vpc-id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "webserver" {
  ami = var.ami-id
  instance_type = var.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.fleetAaccess.id]
  key_name = var.key_name

  tags = {
    Name = "fleet A-1"
  }

  connection {
    type = "ssh"
    host = self.public_ip
    user = var.ssh_user
    private_key = file(var.private_key_path)
    timeout = "4m"
  }

  provisioner "local-exec" {
    command = "touch file1.txt"
  }

}

output "instance_ip" {
  value = aws_instance.webserver.public_ip
}