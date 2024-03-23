module "vpc" {
  source = "/mnt/c/Users/adity/OneDrive/Desktop/Project/Resources/VPC"
  this_vpc_cidr_block = "10.0.0.0/16"
  this_vpc_tags = "this_vpc"
  this_subnet_pub_cidr_block = "10.0.0.0/17"
  this_subnet_private1_cidr_block = "10.0.128.0/19"
  this_subnet_pub_map_ip = true
  this_subnet_private_map_ip = false
  this_subnet_pub_tags = "pub_subnet"
  this_subnet_private1_tags = "pri_subnet1"
  this_subnet_private2_cidr_block = "10.0.192.0/20"
  this_subnet_private2_tags = "pri_subnet2"
  this_igw_tags = "igw"
  this_def_Route_example_cidr_block = "0.0.0.0/0"
  this_def_Route_example_tag = "default"
}

module "ec2" {
  source = "/mnt/c/Users/adity/OneDrive/Desktop/Project/Resources/EC2"
  this_aws_instance_ami = "ami-0ba259e664698cbfc"
  this_aws_instance_instance_type = "t2.micro"
  this_aws_instance_key_name = "mkpint-aaditya"
  this_aws_instance_availability_zone = "ap-south-1b"
  this_aws_instance_volume_size = 20
  //this_aws_instance_count = 1
  this_aws_instance_tags = "New_instance"
  this_aws_instance_subnet = module.vpc.subnet_id
  this_sg_vpc_id = module.vpc.vpc_id
}