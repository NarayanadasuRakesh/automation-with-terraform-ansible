output "az" {
  value = data.aws_availability_zones.az.names
}

output "allocated_az" {
  value = slice(data.aws_availability_zones.az.names,0,2)
}