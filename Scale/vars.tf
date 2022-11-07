variable "vpc-id" {
  default = "vpc-01893f432ca96b8b4"
}
variable "ami-id" {
  default = "ami-0cabc39acf991f4f1" # Amazon Linux 2 AMI (HVM) - Kernel 4.14, SSD Volume Type
}
variable "private_key_path" {
  default = "/Users/Geric/Desktop/Learning/Devops/AutoScale/mykey.pem"
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