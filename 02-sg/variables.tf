variable "project_name" {
  default = "robotshop"
}

variable "environment" {
  default = "dev"
}

variable "common_tags" {
  default = {
    Name        = "robotshop"
    Environment = "dev"
    Terraform   = "true"
  }
}