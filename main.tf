provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.region}"
    token = "${var.token}"
}

module "s3" {
    source = "/home/geric/Desktop/learning/Devops/AutoScale/S3/website"
    #bucket name should be unique
    bucket_name = "awsricscaling"       
}

module "Scale" {
  source = "/home/geric/Desktop/learning/Devops/AutoScale/Scale"
}