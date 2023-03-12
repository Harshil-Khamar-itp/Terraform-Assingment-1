output "VPC" {
    value = module.vpc.vpc_id
}

output "dbEndpoing" {
  value = module.rds.db_instance_address
}