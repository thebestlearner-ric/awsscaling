variable "vpc-id" {
  default = "vpc-01d565d701b2c26b3"
}
variable "ami-id" {
  default = "ami-0149b2da6ceec4bb0" # Ubuntu Server 20.04 LTS (HVM), SSD Volume Type (64-bit (x86))
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
  default = "t3.micro"
}
