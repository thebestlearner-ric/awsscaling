provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.region}"
    token = "${var.token}"
}

module "s3" {
    source = "/Users/Geric/Desktop/Learning/Devops/AutoScale/S3"
    #bucket name should be unique
    bucket_name = "awsricscaling"       
}

module "Scale" {
  source = "/Users/Geric/Desktop/Learning/Devops/AutoScale/Scale"
  region = "${var.region}"
}