variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "enable_dns_hostnames" {
  type = bool
  default = true
}

variable "common_tags" {
  type = map
  default = {
    Project = "robotshop"
    Environment = "dev"
    Terraform = true
  }
}

variable "vpc_tags" {
  default = {}
}

variable "project_name" {
  default = "roboshop"
}

variable "environment" {
  default = "dev"
}

variable "igw_tags" {
  type = map
  default = {
    Purpose = "Internet Gateway for VPC"
  }
}


variable "public_subnets_cidr" {
  default = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "public_subnets_tags" {
  default = {
    Type = "public"
  }
}

variable "private_subnets_cidr" {
  default = ["10.0.11.0/24","10.0.12.0/24"]
}

variable "private_subnets_tags" {
  default = {
    type = "private"
  }
}

variable "database_subnets_cidr" {
  default = ["10.0.21.0/24","10.0.22.0/24"]
}

variable "database_subnets_tags" {
  default = {
    Type = "database"
  }
}

variable "is_vpc_peering_required" {
  default = true
}