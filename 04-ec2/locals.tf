locals {
  name = "${var.project_name}-${var.environment}"
  database_subnet_ids = element(split(",", data.aws_ssm_parameter.database_subnet_ids.value),0)
}
