resource "aws_instance" "oink" {
  count         = "${var.ec2_instance_count}"
  ami           = "${var.ec2_ami_id}"
  instance_type = "${var.ec2_instance_size}"
  key_name = "${aws_key_pair.oink.id}"
  subnet_id = "${var.subnet_id}"
  vpc_security_group_ids = ["${aws_security_group.oink.id}"]

  tags {
    Name = "nginx-${count.index}"
  }

  root_block_device {
    volume_size = "8"
  }

  provisioner "file" {
    source = "config/oink.conf"
    destination = "/home/ubuntu/oink"
    connection {
      user = "ubuntu"
      private_key = "${file("${var.identity_location}")}"
      host = "${self.public_ip}"
    }
  }

  provisioner "remote-exec" {
    connection {
      user = "ubuntu"
      private_key = "${file("${var.identity_location}")}"
      host = "${self.public_ip}"
    }

    inline = [
      "sudo apt-get install -y nginx",
      "sudo mv /home/ubuntu/oink /etc/nginx/sites-available/oink",
      "sudo ln -s /etc/nginx/sites-available/oink /etc/nginx/sites-enabled/oink",
      "sudo rm /etc/nginx/sites-enabled/default",
      "sudo systemctl reload nginx"
    ]
  }

}

resource "aws_security_group" "oink" {
  name        = "${var.appname}-${var.prefix}-oink"
  description = "oinkgo"
  #vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

output "oink ip" {
  value = "${aws_instance.oink.*.public_ip}"
}