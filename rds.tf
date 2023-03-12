module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "5.6.0"

  identifier = "assignmentrds"
  db_name = "assignmentDB"
  password = var.password
  username = var.userName
  port = 3306
  availability_zone = data.aws_availability_zones.az.names[0]
  create_db_option_group = false
  create_db_parameter_group = false
  create_db_subnet_group = false
  create_random_password = false
  skip_final_snapshot = true
  instance_class = "db.t2.micro"
  allocated_storage = 10
  max_allocated_storage = 10
  storage_type = "gp2"
  storage_encrypted = false
  publicly_accessible = false
  engine = "mysql"
  tags = {
      "Name" = "RDS Assignment"
      "Owner" = "harshil.khamar@intuitive.cloud"
    }
  db_subnet_group_name = aws_db_subnet_group.dbSubnetGroup.name
  subnet_ids = aws_db_subnet_group.dbSubnetGroup.*.id
  vpc_security_group_ids = [ aws_security_group.dbSG.id]
}

