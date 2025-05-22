provider "aws" {
  region = "us-west-2"
}

module "network_inspection" {
  source = "../../"
  
  vpc_tags = {
    Environment = "production"
  }
  
  subnet_tags = {
    Type = "private"
  }
}

output "production_vpcs" {
  value = module.network_inspection.vpc_ids
}

output "private_subnets" {
  value = module.network_inspection.subnet_ids
}

output "subnet_az_mapping" {
  value = module.network_inspection.subnet_availability_zones
}

output "subnets_by_vpc" {
  value = module.network_inspection.subnets_by_vpc
} 