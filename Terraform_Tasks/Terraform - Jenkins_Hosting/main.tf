resource "aws_instance" "this_instance_1" {
  ami                    = "ami-03bb6d83c60fc5f7c"
  instance_type          = "t2.micro"
  key_name               = "mkpint-aaditya"
  vpc_security_group_ids = [aws_security_group.this_security_gp.id]
  availability_zone      = "ap-south-1a"
  root_block_device {
    volume_size = 17
  }
  //user_data_base64 = false

  user_data = <<-EOF
  #! /bin/bash
  sudo apt-get update
  sudo apt-get install -y default-jdk
  sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
  echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
  sudo apt-get update
  sudo apt-get install -y jenkins
  EOF

  tags = {
    Name = "Jenkins_instance"
  }
}

resource "aws_security_group" "this_security_gp" {
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}