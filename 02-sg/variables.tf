variable "project_name" {
  default = "roboshop"
}

variable "environment" {
  default = "dev"
}

variable "common_tags" {
  default = {
    Name        = "roboshop"
    Environment = "dev"
    Terraform   = "true"
  }
}