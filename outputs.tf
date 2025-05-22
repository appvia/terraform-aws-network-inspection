output "vpc_ids" {
  description = "List of all VPC IDs that match the filter criteria"
  value       = data.aws_vpcs.all.ids
}

output "vpcs" {
  description = "Map of VPC ID to VPC details"
  value       = data.aws_vpc.selected
}

output "subnet_ids" {
  description = "List of all subnet IDs that match the filter criteria"
  value       = data.aws_subnets.all.ids
}

output "subnets" {
  description = "Map of subnet ID to subnet details"
  value       = data.aws_subnet.selected
}

output "vpc_cidr_blocks" {
  description = "Map of VPC ID to CIDR block"
  value       = { for id, vpc in data.aws_vpc.selected : id => vpc.cidr_block }
}

output "vpc_names" {
  description = "Map of VPC ID to Name tag (if available)"
  value       = { for id, vpc in data.aws_vpc.selected : id => lookup(vpc.tags, "Name", null) }
}

output "subnet_cidr_blocks" {
  description = "Map of subnet ID to CIDR block"
  value       = { for id, subnet in data.aws_subnet.selected : id => subnet.cidr_block }
}

output "subnet_availability_zones" {
  description = "Map of subnet ID to availability zone"
  value       = { for id, subnet in data.aws_subnet.selected : id => subnet.availability_zone }
}

output "subnet_names" {
  description = "Map of subnet ID to Name tag (if available)"
  value       = { for id, subnet in data.aws_subnet.selected : id => lookup(subnet.tags, "Name", null) }
}

output "subnets_by_vpc" {
  description = "Map of VPC ID to list of subnet IDs in that VPC"
  value       = { for id, vpc in data.aws_vpc.selected : id => [for subnet_id, subnet in data.aws_subnet.selected : subnet_id if subnet.vpc_id == id] }
} 