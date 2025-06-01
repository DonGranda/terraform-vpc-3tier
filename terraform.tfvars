project_name = "myapp-infra"
environment  = "dev"

# VPC Configuration
vpc_cidr                = "10.0.0.0/16"
enable_dns_hostnames    = true
enable_dns_support      = true

public_subnet_cidrs = [
    "10.0.1.0/24",  
    "10.0.2.0/24"    
]

private_subnet_cidrs = [ 
    "10.0.3.0/24",
    "10.0.4.0/24",
    "10.0.5.0/24",
    "10.0.6.0/24"   
]