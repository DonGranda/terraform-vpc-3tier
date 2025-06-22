module "vpc" {

  source               = "./modules/vpc"
  project_name         = var.project_name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  availability_zones   = data.aws_availability_zones.available.names
}

module "subnets" {
  source               = "./modules/subnets"
  vpc_id               = module.vpc.vpc_id
  internet_gateway_id  = module.vpc.internet_gateway_id
  nat_eip_ids          = module.vpc.nat_eip_ids
  availability_zones   = slice(data.aws_availability_zones.available.names, 0, length(var.public_subnet_cidrs))
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  project_name         = var.project_name
  environment          = var.environment
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id

  project_name = var.project_name
  environment  = var.environment
  depends_on   = [module.vpc]

}

module "rds_db" {
  source       = "./modules/db"
  project_name = var.project_name
  environment  = var.environment

  # Database configuration
  db_engine             = var.db_engine
  db_engine_version     = var.db_engine_version
  db_instance_class     = var.db_instance_class
  db_security_group_id  = module.security_groups.db_security_group_id
  db_private_subnet_ids = module.subnets.db_private_subnets_ids

  # Database storage configuration
  db_allocated_storage     = var.db_allocated_storage
  db_max_allocated_storage = var.db_max_allocated_storage
  db_storage_type          = var.db_storage_type
  db_storage_encrypted     = var.db_storage_encrypted

  #db credentials
  db_name     = var.db_name
  db_username = var.db_username

  # depends_on = [
  #   module.subnets,           
  #   module.security_groups    
  # ]

}

module "web_server " {
  source       = "./modules/web_server"
  project_name = var.project_name
  environment  = var.environment

  instance_type               = var.instance_type
  app_security_group_id       = module.security_groups.app_security_group_id
  app_private_subnets_ids_map = module.subnets.app_private_subnet_ids_map
}



