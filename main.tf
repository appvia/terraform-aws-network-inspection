terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
  }
}

# Data source to fetch VPCs with optional tag filtering
data "aws_vpcs" "all" {
  filter {
    name   = "state"
    values = ["available"]
  }

  dynamic "filter" {
    for_each = var.vpc_tags
    content {
      name   = "tag:${filter.key}"
      values = [filter.value]
    }
  }
}

# Data source to fetch detailed information for each VPC
data "aws_vpc" "selected" {
  for_each = toset(data.aws_vpcs.all.ids)
  id       = each.value
}

# Data source to fetch all subnets with optional tag filtering
data "aws_subnets" "all" {
  filter {
    name   = "state"
    values = ["available"]
  }

  dynamic "filter" {
    for_each = var.subnet_tags
    content {
      name   = "tag:${filter.key}"
      values = [filter.value]
    }
  }
}

# Data source to fetch detailed information for each subnet
data "aws_subnet" "selected" {
  for_each = toset(data.aws_subnets.all.ids)
  id       = each.value
} 