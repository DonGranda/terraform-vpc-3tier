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

}