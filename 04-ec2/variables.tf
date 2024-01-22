variable "project_name" {
  type = string
  default = "robotshop"
}

variable "environment" {
  type = string
  default = "dev"
}

variable "common_tags" {
  type = map
  default = {
    Project = "robotshop"
    Environment = "dev"
    Terraform = "true"
  }
}

variable "zone_id" {
  type = string
  default = "rakeshintech.online"
}