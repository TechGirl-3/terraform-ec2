variable region {
  default = "us-east-1"
}

variable "subnet_az" {
  default = "us-east-1a"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}
variable "subnet_cidr_block" {
  default = "10.0.0.0/24"
}

variable "inst_type" {
  default = "t2.micro"
}

variable "ami_id" {
  default = "ami-0ffd59b53e6797671"
}

variable "ami_owner" {
  default = "self"
}

#Tags

variable "vpc_tagkey" {
  default = "sre-vpc"
}

variable "subnet_tagkey" {
  default = "sre-subnet"
}
