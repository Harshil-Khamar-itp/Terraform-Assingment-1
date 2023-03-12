module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"
  name = "AssignmentVPC"
  cidr = var.vpcCidr
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false
  azs = [data.aws_availability_zones.az.names[0],data.aws_availability_zones.az.names[1],data.aws_availability_zones.az.names[2]]
}

data "aws_availability_zones" "az" {
  
}

resource "aws_subnet" "dbSubnet" {
    count = 3
    tags = {
        "Name" = "private db subnet ${count.index}"
        "Owner" = "harshil.khamar@intuitive.cloud"
    }
    cidr_block = var.privateDbSubnetCidr[count.index]
    availability_zone = data.aws_availability_zones.az.names[count.index]
    vpc_id = module.vpc.vpc_id
}

resource "aws_db_subnet_group" "dbSubnetGroup" {
  name = "rdssubnetgroup"
  subnet_ids = aws_subnet.dbSubnet.*.id
}