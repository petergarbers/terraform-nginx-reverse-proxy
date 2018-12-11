appname = "weird-nginx" # Change to your nginxname
prefix = "development"
profile = "devthenet" # Change to your key
region = "us-east-1"

subnet_id = "subnet-f64f60bc" # I should create it's own subnet but... Just copy this from your other instance
vpc_id = "vpc-604ee61a" # I should also create its own vpc... Just copy from existing

identity_location = "/home/peter/.ssh/id_devthenet_aws" # Change to your key location

ec2_ami_id = "ami-0f9cf087c1f27d9b1"
ec2_instance_size = "t2.micro"
ec2_instance_count = 1