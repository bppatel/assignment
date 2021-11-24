variable "image_id" {
  type    = string
  default = "ami-0108d6a82a783b352"
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "subnet_ids" {
  type    = list(string)
  default = ["subnet-fd7ce0b6"]
}

variable "aws_region" {
  default = "ap-south-1"
}
variable "instance_name" {
  default = "terra-ansible0"
}
/*variable "instance_name" {
  type    = list(string)
  default = ["terra-ansible01","terra-ansible02"]
}*/
variable "ami_id" {
  default = "ami-0108d6a82a783b352"
}
variable "ssh_user_name" {
  default = "ec2-user"
}
variable "ssh_key_name" {
  default = "elastic"
}
variable "ssh_key_path" {
  default = "/tmp/elastic.pem"
}
variable "instance_count" {
  default = 1
}
variable "subnet_id" {
  default = "subnet-0ce25834580c94838"
}
variable "dev_host_label" {
  default = "terra_ansible_host"
}
variable "vpc_id" {
  default = "vpc-095c30456566f9273"
}
