variable "vpc-id" {
  default = "vpc-04a77969699adca04"
}
variable "ami-id" {
  default = "ami-0149b2da6ceec4bb0" # Ubuntu Server 20.04 LTS (HVM), SSD Volume Type (64-bit (x86))
  # default = "ami-050406429a71aaa64" # Debian 11
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
  default = "t2.medium"
}
