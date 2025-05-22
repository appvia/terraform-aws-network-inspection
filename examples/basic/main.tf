provider "aws" {
  region = "us-west-2"
}

module "network_inspection" {
  source = "../../"
}

output "all_vpcs" {
  value = module.network_inspection.vpc_ids
}

output "all_subnets" {
  value = module.network_inspection.subnet_ids
}

output "vpc_details" {
  value = module.network_inspection.vpc_cidr_blocks
} 