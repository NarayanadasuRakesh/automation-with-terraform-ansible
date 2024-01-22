module "mongodb" {
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

module "redis" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${local.name}-redis"
  ami = data.aws_ami.centos8.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.redis_sg_id.value]
  subnet_id              = local.database_subnet_ids

  tags = merge(
    var.common_tags,
    {
        Name = "${local.name}-redis"
        Component = "redis"
    }
  )
}

module "mysql" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${local.name}-mysql"
  ami = data.aws_ami.centos8.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.mysql_sg_id.value]
  subnet_id              = local.database_subnet_ids

  tags = merge(
    var.common_tags,
    {
        Name = "${local.name}-mysql"
        Component = "mysql"
    }
  )
}

module "rabbitmq" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${local.name}-rabbitmq"
  ami = data.aws_ami.centos8.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.rabbitmq_sg_id.value]
  subnet_id              = local.database_subnet_ids

  tags = merge(
    var.common_tags,
    {
        Name = "${local.name}-rabbitmq"
        Component = "rabbitmq"
    }
  )
}

module "catalogue" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${local.name}-catalogue"
  ami = data.aws_ami.centos8.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.catalogue_sg_id.value]
  subnet_id              = local.private_subnet_ids

  tags = merge(
    var.common_tags,
    {
        Name = "${local.name}-catalogue"
        Component = "catalogue"
    }
  )
}

module "user" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${local.name}-user"
  ami = data.aws_ami.centos8.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.user_sg_id.value]
  subnet_id              = local.private_subnet_ids

  tags = merge(
    var.common_tags,
    {
        Name = "${local.name}-user"
        Component = "user"
    }
  )
}

module "cart" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${local.name}-cart"
  ami = data.aws_ami.centos8.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.cart_sg_id.value]
  subnet_id              = local.private_subnet_ids

  tags = merge(
    var.common_tags,
    {
        Name = "${local.name}-cart"
        Component = "cart"
    }
  )
}

module "shipping" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${local.name}-shipping"
  ami = data.aws_ami.centos8.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.shipping_sg_id.value]
  subnet_id              = local.private_subnet_ids

  tags = merge(
    var.common_tags,
    {
        Name = "${local.name}-shipping"
        Component = "shipping"
    }
  )
}

module "payment" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${local.name}-payment"
  ami = data.aws_ami.centos8.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.payment_sg_id.value]
  subnet_id              = local.private_subnet_ids

  tags = merge(
    var.common_tags,
    {
        Name = "${local.name}-payment"
        Component = "payment"
    }
  )
}

module "web" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${local.name}-web"
  ami = data.aws_ami.centos8.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.web_sg_id.value]
  subnet_id              = local.private_subnet_ids

  tags = merge(
    var.common_tags,
    {
        Name = "${local.name}-web"
        Component = "web"
    }
  )
}

# Ansible server to provision playbooks to all the EC2 instances
module "ansible" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${local.name}-ansible"
  ami = data.aws_ami.centos8.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
  subnet_id              = data.aws_subnet.selected.id
  user_data = file("servers-provision.sh")
  # user_data = <<-EOF
  #             #!/bin/bash
  #             DIR="automation-with-ansible-roles"
  #             components=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "web")
  #             yum install ansible -y
  #             cd /tmp
  #             if [ -d $DIR ]
  #             then
  #                 rm -r "$DIR"
  #                 echo "Deleted $DIR"
  #             fi
  #             echo "Cloning git repository"
  #             git clone https://github.com/NarayanadasuRakesh/automation-with-ansible-roles.git   
  #             cd automation-with-ansible-roles
  #             for server in "${components[@]}"
  #             do
  #                 echo "Installing $server"
  #                 ansible-playbook -e component=$server main.yml
  #             done
  #             EOF

  tags = merge(
    var.common_tags,
    {
        Name = "${local.name}-ansible"
        Component = "ansible"
    }
  )
}

# Create Route53 A records

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  zone_name = var.zone_id
  records = [
    {
      name    = "mongodb"
      type    = "A"
      ttl     = 1
      records = [module.mongodb.private_ip]
    },

    {
      name    = "redis"
      type    = "A"
      ttl     = 1
      records = [module.redis.private_ip]
    },
    {
      name    = "mysql"
      type    = "A"
      ttl     = 1
      records = [module.mysql.private_ip]
    },
    {
      name    = "rabbitmq"
      type    = "A"
      ttl     = 1
      records = [module.rabbitmq.private_ip]
    },
    {
      name    = "catalogue"
      type    = "A"
      ttl     = 1
      records = [module.catalogue.private_ip]
    },
    {
      name    = "user"
      type    = "A"
      ttl     = 1
      records = [module.user.private_ip]
    },
    {
      name    = "cart"
      type    = "A"
      ttl     = 1
      records = [module.cart.private_ip]
    },
    {
      name    = "shipping"
      type    = "A"
      ttl     = 1
      records = [module.shipping.private_ip]
    },
    {
      name    = "payment"
      type    = "A"
      ttl     = 1
      records = [module.payment.private_ip]
    },
    {
      name    = "web"
      type    = "A"
      ttl     = 1
      records = [module.web.private_ip]
    }
  ]
}
