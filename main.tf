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

# Data source to fetch public subnets within the selected VPCs
data "aws_subnets" "public" {
  filter {
    name   = "state"
    values = ["available"]
  }
  
  filter {
    name   = "vpc-id"
    values = data.aws_vpcs.all.ids
  }

  filter {
    name   = "tag:Tier"
    values = ["public"]
  }

  dynamic "filter" {
    for_each = var.subnet_tags
    content {
      name   = "tag:${filter.key}"
      values = [filter.value]
    }
  }
}

# Data source to fetch private subnets within the selected VPCs
data "aws_subnets" "private" {
  filter {
    name   = "state"
    values = ["available"]
  }
  
  filter {
    name   = "vpc-id"
    values = data.aws_vpcs.all.ids
  }

  filter {
    name   = "tag:Tier"
    values = ["private"]
  }

  dynamic "filter" {
    for_each = var.subnet_tags
    content {
      name   = "tag:${filter.key}"
      values = [filter.value]
    }
  }
}

# Data source to fetch detailed information for each public subnet
data "aws_subnet" "public" {
  for_each = toset(data.aws_subnets.public.ids)
  id       = each.value
}

# Data source to fetch detailed information for each private subnet
data "aws_subnet" "private" {
  for_each = toset(data.aws_subnets.private.ids)
  id       = each.value
} 