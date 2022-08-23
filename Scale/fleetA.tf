resource "aws_security_group" "fleetAaccess" {
  name   = "fleetAaccess"
  vpc_id = var.vpc-id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_availability_zones" "all" {}

resource "aws_launch_configuration" "asg-launch-config" {
	image_id = var.ami-id
	instance_type = var.instance_type
	security_groups = [aws_security_group.fleetAaccess.id]

	provisioner "remote-exec" {
		inline = [
			"sudo amazon-linux-extras install -y nginx1.12",
			"sudo systemctl start nginx"
		]
	}
}

resource "aws_instance" "webserver" {
  ami                         = var.ami-id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.fleetAaccess.id]
  key_name                    = var.key_name

  tags = {
    Name = "fleet A-1"
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = var.ssh_user
    private_key = file(var.private_key_path)
    timeout     = "4m"
  }

  provisioner "local-exec" {
    command = "echo '[nginx]\\n${self.public_ip}' | tee Scale/ansible/myhosts"
  }
  provisioner "local-exec" {
    command = "ansible-playbook -i Scale/ansible/myhosts --user ${var.ssh_user} --private-key ${var.private_key_path} Scale/ansible/playbook.yml"
  }
}
# Creating the autoscaling group within us-east-1a availability zone
resource "aws_autoscaling_group" "autoscalefleetA" {
# Defining the availability Zone in which AWS EC2 instance will be launched
  availability_zones        = ["us-east-1a"]
# Specifying the name of the autoscaling group
  name                      = "fleetA"
# Defining the maximum number of AWS EC2 instances while scaling
  max_size                  = 6
# Defining the minimum number of AWS EC2 instances while scaling
  min_size                  = 3
# Grace period is the time after which AWS EC2 instance comes into service before checking health.
  health_check_grace_period = 30
# The Autoscaling will happen based on health of AWS EC2 instance defined in AWS CLoudwatch Alarm 
  health_check_type         = "EC2"
# force_delete deletes the Auto Scaling Group without waiting for all instances in the pool to terminate
  force_delete              = true
# Defining the termination policy where the oldest instance will be replaced first 
  termination_policies      = ["OldestInstance"]
# Scaling group is dependent on autoscaling launch configuration because of AWS EC2 instance configurations
  launch_configuration      = aws_launch_configuration.asg-launch-config.name
}

output "instance_ip" {
  value = aws_instance.webserver.public_ip
}
