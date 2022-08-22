variable "vpc-id" {
  default = "vpc-06ecbdb717cae7945"
}
variable "ami-id" {
  default = "ami-0729e439b6769d6ab"
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