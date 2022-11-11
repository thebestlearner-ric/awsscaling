variable "vpc-id" {
  default = "vpc-0519697bb9628db83"
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
