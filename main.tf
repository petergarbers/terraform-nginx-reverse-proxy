variable "appname" {
  default = ""
}

variable "prefix" {}
variable "profile" {}

variable "region" {
  default = "us-west-2"
}

provider "aws" {
  profile    = "${var.profile}"
  region     = "${var.region}"
}

terraform {
  backend "s3" {
  }
}

# ec2
variable "ec2_ami_id" {}
variable "ec2_instance_size" {}
variable "ec2_instance_count" {}

# keypair
variable "identity_location" {}

# EXISTING RESOURCES
variable "subnet_id" {}
variable "vpc_id" {} # Default vpc that is used for everything, should probably change