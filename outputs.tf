output "vpc_ids" {
  description = "List of all VPC IDs that match the filter criteria"
  value       = data.aws_vpcs.all.ids
}

output "vpcs" {
  description = "Map of VPC ID to VPC details"
  value       = data.aws_vpc.selected
}

output "public_subnet_ids" {
  description = "List of all public subnet IDs that match the filter criteria"
  value       = data.aws_subnets.public.ids
}

output "private_subnet_ids" {
  description = "List of all private subnet IDs that match the filter criteria"
  value       = data.aws_subnets.private.ids
}

output "public_subnets" {
  description = "Map of public subnet ID to subnet details"
  value       = data.aws_subnet.public
}

output "private_subnets" {
  description = "Map of private subnet ID to subnet details"
  value       = data.aws_subnet.private
}

output "vpc_cidr_blocks" {
  description = "Map of VPC ID to CIDR block"
  value       = { for id, vpc in data.aws_vpc.selected : id => vpc.cidr_block }
}

output "vpc_names" {
  description = "Map of VPC ID to Name tag (if available)"
  value       = { for id, vpc in data.aws_vpc.selected : id => lookup(vpc.tags, "Name", null) }
}

output "public_subnet_cidr_blocks" {
  description = "Map of public subnet ID to CIDR block"
  value       = { for id, subnet in data.aws_subnet.public : id => subnet.cidr_block }
}

output "private_subnet_cidr_blocks" {
  description = "Map of private subnet ID to CIDR block"
  value       = { for id, subnet in data.aws_subnet.private : id => subnet.cidr_block }
}

output "public_subnet_availability_zones" {
  description = "Map of public subnet ID to availability zone"
  value       = { for id, subnet in data.aws_subnet.public : id => subnet.availability_zone }
}

output "private_subnet_availability_zones" {
  description = "Map of private subnet ID to availability zone"
  value       = { for id, subnet in data.aws_subnet.private : id => subnet.availability_zone }
}

output "public_subnet_names" {
  description = "Map of public subnet ID to Name tag (if available)"
  value       = { for id, subnet in data.aws_subnet.public : id => lookup(subnet.tags, "Name", null) }
}

output "private_subnet_names" {
  description = "Map of private subnet ID to Name tag (if available)"
  value       = { for id, subnet in data.aws_subnet.private : id => lookup(subnet.tags, "Name", null) }
}

output "public_subnets_by_vpc" {
  description = "Map of VPC ID to list of public subnet IDs in that VPC"
  value       = { for id, vpc in data.aws_vpc.selected : id => [for subnet_id, subnet in data.aws_subnet.public : subnet_id if subnet.vpc_id == id] }
}

output "private_subnets_by_vpc" {
  description = "Map of VPC ID to list of private subnet IDs in that VPC"
  value       = { for id, vpc in data.aws_vpc.selected : id => [for subnet_id, subnet in data.aws_subnet.private : subnet_id if subnet.vpc_id == id] }
} 