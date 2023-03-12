resource "aws_security_group" "lbSg" {
    name = "ALBSecurityGroup"
    vpc_id = module.vpc.vpc_id
    ingress = [ {
      cidr_blocks = [ "0.0.0.0/0" ]
      description = "Allow All Traffic"
      from_port = 0
      ipv6_cidr_blocks = [  ]
      prefix_list_ids = [  ]
      protocol = "ALL"
      security_groups = [  ]
      self = false
      to_port = 0
    } ]
    egress = [ 
        {
            cidr_blocks = [ "0.0.0.0/0" ]
            description = "Allow All Traffic"
            from_port = 0
            ipv6_cidr_blocks = [  ]
            prefix_list_ids = [  ]
            protocol = "-1"
            security_groups = [  ]
            self = false
            to_port = 0
        }
     ]
}

resource "aws_security_group" "ec2Sg" {
  name = "ALBSecurityGroup1"
  vpc_id = module.vpc.vpc_id
    ingress = [ {
        cidr_blocks = [ ]
        description = "Allow All Traffic"
        from_port = 0
        ipv6_cidr_blocks = [  ]
        prefix_list_ids = [  ]
        protocol = "ALL"
        security_groups = [  ]
        self = false
        to_port = 0
        security_groups = [aws_security_group.lbSg.id]
    },
     ]
    egress = [ 
        {
            cidr_blocks = [ "0.0.0.0/0" ]
            description = "Allow All Traffic"
            from_port = 0
            ipv6_cidr_blocks = [  ]
            prefix_list_ids = [  ]
            protocol = "-1"
            security_groups = [  ]
            self = false
            to_port = 0
        }
     ]
}

resource "aws_security_group" "dbSG" {
    name = "DBSG"
    vpc_id = module.vpc.vpc_id
    ingress = [ {
      cidr_blocks = [ ]
      from_port = 0
      protocol = "ALL"
      self = false
      to_port = 0
      ipv6_cidr_blocks = []
      description = "Allow Inbound"
      security_groups = [aws_security_group.ec2Sg.id]
      prefix_list_ids = []
    } ]
    egress = [ {
      cidr_blocks = [ "0.0.0.0/0" ]
      from_port = 0
      protocol = "ALL"
      description = "Allow Outbound"
      ipv6_cidr_blocks = []
      self = false
      security_groups = []
      prefix_list_ids = []
      to_port = 0
    } ]
}