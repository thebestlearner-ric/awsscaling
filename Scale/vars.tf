variable "vpc-id" {
  default = "vpc-04f51ec875d57c1a7"
}
variable "ami-id" {
  default = "ami-0cabc39acf991f4f1" # Amazon Linux 2 AMI (HVM) - Kernel 4.14, SSD Volume Type
}
variable "private_key_path" {
  default = "/home/geric/Desktop/learning/Devops/AutoScale/scalekey.pem"
}
variable "ssh_user" {
  default = "ubuntu"
}
variable "key_name" {
  default = "scalekey"
}
variable "instance_type" {
  default = "t2.micro"
}