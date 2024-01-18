module "mongodb_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${local.name}-mondodb"
  ami = data.aws_ami.centos8.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.mongodb_sg_id.value]
  subnet_id              = local.database_subnet_ids

  tags = merge(
    var.common_tags,
    {
        Name = "${local.name}-mongodb"
        Component = "mongodb"
    }
  )
}