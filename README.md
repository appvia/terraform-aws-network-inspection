# Terraform AWS Network Inspection Module

This module uses data resources to inspect the available AWS VPCs and subnets in an AWS account. It provides all the outputs of the data resources as outputs of the module, allowing you to filter VPCs and subnets by tags.

## Features

- List all available VPCs and their details
- Automatically categorize subnets into public and private based on the "Tier" tag
- Filter VPCs and subnets by tags
- Get VPC and subnet attributes including CIDR blocks, availability zones, etc.
- Organize subnets by VPC

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| aws | >= 4.0.0 |

## Usage

### Basic Usage

```hcl
module "network_inspection" {
  source = "path/to/module"
}

# Access outputs
output "all_vpcs" {
  value = module.network_inspection.vpc_ids
}

output "public_subnets" {
  value = module.network_inspection.public_subnet_ids
}

output "private_subnets" {
  value = module.network_inspection.private_subnet_ids
}
```

### Filtering by Tags

```hcl
module "network_inspection" {
  source = "path/to/module"
  
  vpc_tags = {
    Environment = "production"
  }
  
  subnet_tags = {
    Type = "application"
  }
}
```

## Subnet Classification

Subnets are automatically classified as:
- **Public subnets**: Subnets with tag `Tier = public`
- **Private subnets**: Subnets with tag `Tier = private`

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| vpc_tags | Map of tags to filter VPCs by | `map(string)` | `{}` | no |
| subnet_tags | Map of tags to filter subnets by | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc_ids | List of all VPC IDs that match the filter criteria |
| vpcs | Map of VPC ID to VPC details |
| public_subnet_ids | List of all public subnet IDs that match the filter criteria |
| private_subnet_ids | List of all private subnet IDs that match the filter criteria |
| public_subnets | Map of public subnet ID to subnet details |
| private_subnets | Map of private subnet ID to subnet details |
| vpc_cidr_blocks | Map of VPC ID to CIDR block |
| vpc_names | Map of VPC ID to Name tag (if available) |
| public_subnet_cidr_blocks | Map of public subnet ID to CIDR block |
| private_subnet_cidr_blocks | Map of private subnet ID to CIDR block |
| public_subnet_availability_zones | Map of public subnet ID to availability zone |
| private_subnet_availability_zones | Map of private subnet ID to availability zone |
| public_subnet_names | Map of public subnet ID to Name tag (if available) |
| private_subnet_names | Map of private subnet ID to Name tag (if available) |
| public_subnets_by_vpc | Map of VPC ID to list of public subnet IDs in that VPC |
| private_subnets_by_vpc | Map of VPC ID to list of private subnet IDs in that VPC |

## Example Output

When you run `terraform apply`, you'll see outputs similar to:

```
Outputs:

vpc_ids = [
  "vpc-012345abcdef",
  "vpc-67890ghijkl"
]
public_subnet_ids = [
  "subnet-123abc456def"
]
private_subnet_ids = [
  "subnet-789ghi012jkl"
]
vpc_cidr_blocks = {
  "vpc-012345abcdef" = "10.0.0.0/16"
  "vpc-67890ghijkl" = "172.16.0.0/16"
}
```

## License

This module is licensed under the MIT License. 