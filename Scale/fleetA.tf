variable "region" {
  description = "availability regions"
}


resource "aws_security_group" "fleetAControlaccess" {
  name   = "fleetAControlaccess"
  vpc_id = var.vpc-id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "For remote access with ssh"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "For Http access"
  }
  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "For Kubernetes API server"
  }
  ingress {
    from_port   = 2379
    to_port     = 2380
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "For mysql access"
  }
  ingress {
    from_port   = 10259
    to_port     = 10259
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "For kube-scheduler"
  }
  ingress {
    from_port   = 10257
    to_port     = 10257
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "For kube-controller-manager"
  }
  ingress {
    from_port   = 8472
    to_port     = 8472
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Cluster-Wide Network Comm"
  }
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "For mysql access"
  }
   ingress {
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "NodePort Services"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "fleetAaccess" {
  name   = "fleetAaccess"
  vpc_id = var.vpc-id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "For remote access with ssh"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "For Http access"
  }
  ingress {
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "For Kubelet API"
  }
  ingress {
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "NodePort Services"
  }
  ingress {
    from_port   = 8472
    to_port     = 8472
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Cluster-Wide Network Comm"
  }
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "For mysql access"
  }
  ingress {
    from_port   = 5901
    to_port     = 5901
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "For mysql access"
  }
  ingress {
    from_port   = 8001
    to_port     = 8001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "For mysql access"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_availability_zones" "all" {}

# resource "aws_launch_template" "nginx" {
#   name_prefix            = "fleetA-webserver-"
#   image_id               = var.ami-id
#   instance_type          = var.instance_type
#   vpc_security_group_ids = [aws_security_group.fleetAaccess.id]
#   #user_data = "$(file(install_nginx.sh))"

# }

# resource "aws_autoscaling_group" "fleetA" {
#   availability_zones = data.aws_availability_zones.all.names
#   desired_capacity   = 3
#   max_size           = 3
#   min_size           = 3

#   lifecycle {
#     create_before_destroy = true
#   }
#   launch_template {
#     id      = aws_launch_template.nginx.id
#     version = "$Latest"
#   }
# }

# resource "aws_instance" "webserver" {
#   ami                         = var.ami-id
#   instance_type               = var.instance_type
#   associate_public_ip_address = true
#   vpc_security_group_ids      = [aws_security_group.fleetAaccess.id]
#   key_name                    = var.key_name

#   tags = {
#     Name = "fleet A-1"
#   }

#   connection {
#     type        = "ssh"
#     host        = self.public_ip
#     user        = var.ssh_user
#     private_key = file(var.private_key_path)
#     timeout     = "4m"
#   }

#   provisioner "local-exec" {
#     command = "echo '[nginx]\\n${self.public_ip}' | tee Scale/ansible/myhosts"
#   }
#   provisioner "local-exec" {
#     command = "ansible-playbook -i Scale/ansible/myhosts --user ${var.ssh_user} --private-key ${var.private_key_path} Scale/ansible/playbook.yml"
#   }
# }
# provider "shell" {
#     interpreter = ["/bin/sh", "-c"]
#     enable_parallelism = false
# }

# resource "aws_lb_target_group" "tg" {
#   name     = "tf-example-lb-tg"
#   port     = 8443
#   protocol = "HTTP"
#   vpc_id   = var.vpc-id
# }

# resource "aws_lb" "kube_lb" {
#   name               = "kubeLoadBalancer"
#   load_balancer_type = "network"
#   subnet_mapping {
#     subnet_id = local.instance_subnet_id
#     allocation_id = aws_eip.kube_controller_eip.id
#   }

# }

resource "aws_eip" "kube_controller_eip" {
  instance = aws_instance.kube_controller.id
  vpc      = true
}

resource "aws_instance" "kube_controller" {
  ami                         = var.ami-id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.fleetAControlaccess.id, aws_security_group.fleetAaccess.id]
  key_name                    = var.key_name
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "kube_worker1" {
  ami                         = var.ami-id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.fleetAControlaccess.id, aws_security_group.fleetAaccess.id]
  key_name                    = var.key_name
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "kube_worker2" {
  ami                         = var.ami-id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.fleetAControlaccess.id, aws_security_group.fleetAaccess.id]
  key_name                    = var.key_name
  lifecycle {
    create_before_destroy = true
  }
}

# resource "aws_launch_configuration" "asg-launch-config" {
#   image_id                    = var.ami-id
#   instance_type               = var.instance_type
#   security_groups             = [aws_security_group.fleetAControlaccess.id, aws_security_group.fleetAaccess.id]
#   key_name                    = var.key_name
#   associate_public_ip_address = true
#   # user_data = file("Scale/install_nginx.sh")
#   # user_data = file("Scale/get_ag_ip.sh")
#   lifecycle {
#     create_before_destroy = true
#   }
# }

# # Creating the autoscaling group within us-east-1a availability zone
# resource "aws_autoscaling_group" "autoscalefleetA" {
#   # Defining the availability Zone in which AWS EC2 instance will be launched
#   availability_zones = ["us-east-1a"]
#   #availability_zones = data.aws_availability_zones.all.names
#   # Specifying the name of the autoscaling group
#   name = "fleetA"
#   # Defining the maximum number of AWS EC2 instances while scaling
#   max_size = 6
#   # Defining the minimum number of AWS EC2 instances while scaling
#   min_size = 2
#   # Grace period is the time after which AWS EC2 instance comes into service before checking health.
#   health_check_grace_period = 30
#   # The Autoscaling will happen based on health of AWS EC2 instance defined in AWS CLoudwatch Alarm 
#   health_check_type = "EC2"
#   # force_delete deletes the Auto Scaling Group without waiting for all instances in the pool to terminate
#   force_delete = true
#   # Defining the termination policy where the oldest instance will be replaced first 
#   termination_policies = ["OldestInstance"]
#   # Scaling group is dependent on autoscaling launch configuration because of AWS EC2 instance configurations
#   launch_configuration = aws_launch_configuration.asg-launch-config.name
# }

# output "instance_ip" {
#   value = aws_instance.kube_controller.public_ip
# }
