resource "aws_instance" "this_instance" {
  ami                    = data.aws_ami.this_ami.id
  instance_type          = var.this_instance_instance_type
  key_name               = var.this_instance_key_name
  vpc_security_group_ids = [aws_security_group.this_sg.id]
  availability_zone      = "ap-south-1a"
  root_block_device {
    volume_size = 20
  }
  user_data_base64 = true

  tags = {
    Name = "Terraform_instance"
  }
}

resource "aws_security_group" "this_sg" {
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

output "public_ip" {
  value = aws_instance.this_instance.public_ip
  
}
output "instance_state" {
  value = aws_instance.this_instance.instance_state
  
}

data "aws_ami" "this_ami" {
  name_regex = "jenkins-ami"
  owners = ["self"]

  filter {
    name = "name"
    values = ["jenkins-ami"]
  }
}