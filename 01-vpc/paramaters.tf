resource "aws_ssm_parameter" "vpc_ip" {
  name  = "/${var.project_name}/${var.environment}/vpc_id"
  type  = "String"
  value = module.robotshop.vpc_id
}

resource "aws_ssm_parameter" "database_subnet_ids" {
  name  = "/${var.project_name}/${var.environment}/database_subnet_ids"
  type  = "StringList"
  value = join(",", module.robotshop.database_subnet_ids)
}