variable "vpc-id" {
  default = "vpc-044bc07b956025a62"
}
variable "ami-id" {
  default = "ami-0cabc39acf991f4f1" # Amazon Linux 2 AMI (HVM) - Kernel 4.14, SSD Volume Type
}
variable "private_key_path" {
  default = "./mykey.pem"
}
variable "ssh_user" {
  default = "ubuntu"
}
variable "key_name" {
  default = "mykey"
}
variable "instance_type" {
  default = "t2.micro"
}
