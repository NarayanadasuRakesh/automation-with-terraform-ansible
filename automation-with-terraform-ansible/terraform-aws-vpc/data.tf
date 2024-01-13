data "aws_availability_zones" "az" {
  state = "available"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_route_tables" "default" {
  vpc_id = data.aws_vpc.default.id

  filter {
    name   = "association.main"
    values = ["true"]
  }
}