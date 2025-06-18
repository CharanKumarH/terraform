terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0-beta3"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
}


provider "aws" {
  # Configuration options
  region = "ap-south-1"

}

#  # --------------------------------------------------------------
#  # Example of creating multiple VPCs and subnets using count

# locals {
#   project_name = "project_demo"
# }

# resource "aws_vpc" "my_vpc" {
#   count      = 1
#   cidr_block = "10.0.${count.index}.0/16"
#   tags = {
#     Name = "${local.project_name}-vpc-${count.index}"
#   }
# }

# resource "aws_subnet" "subnets" {
#   count      = 2
#   vpc_id     = aws_vpc.my_vpc[count.index].id
#   cidr_block = "10.0.${count.index}.0/24"
#   tags = {
#     Name = "${local.project_name}-subnet-${count.index}"
#   }
# }

# ------------------------------------------------------------------


# data "aws_availability_zones" "available" {
#   state = "available"
# }

# locals {
#   project_name      = "myproject"
#   vpc_count         = 5
#   subnets_per_vpc   = 5
# }

# resource "aws_vpc" "my_vpc" {
#   count      = local.vpc_count
#   cidr_block = "10.${count.index}.0.0/16"

#   tags = {
#     Name = "${local.project_name}-vpc-${count.index}"
#   }
# }

# resource "aws_subnet" "subnets" {
#   count = local.vpc_count * local.subnets_per_vpc

#   vpc_id     = aws_vpc.my_vpc[floor(count.index / local.subnets_per_vpc)].id
#   cidr_block = "10.${floor(count.index / local.subnets_per_vpc)}.${count.index % local.subnets_per_vpc}.0/24"

#   tags = {
#     Name = "${local.project_name}-subnet-${floor(count.index / local.subnets_per_vpc)}-${count.index % local.subnets_per_vpc}"
#   }
# }



# output "output" {
#     value = {
#         zones = data.aws_availability_zones.available.names
#         zone_length = length(data.aws_availability_zones.available.names)

# }
# }

# --------------------------------------------------------------
# Example of creating multiple VPCs and subnets using for_each


locals {
  project_name    = "myproject"
  vpc_count       = 5
  subnets_per_vpc = 5
}

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  az_count     = length(data.aws_availability_zones.available.names)
  zone_indices = [for i in range(local.subnets_per_vpc) : i % local.az_count]
}

resource "aws_vpc" "my_vpc" {
  count      = local.vpc_count
  cidr_block = "10.${count.index}.0.0/16"

  tags = {
    Name = "${local.project_name}-vpc-${count.index}"
  }
}

resource "aws_subnet" "subnets" {
  count = local.vpc_count * local.subnets_per_vpc

  vpc_id = aws_vpc.my_vpc[floor(count.index / local.subnets_per_vpc)].id

  cidr_block = "10.${floor(count.index / local.subnets_per_vpc)}.${count.index % local.subnets_per_vpc}.0/24"

  availability_zone = data.aws_availability_zones.available.names[
    local.zone_indices[count.index % local.subnets_per_vpc]
  ]

  tags = {
    Name = "${local.project_name}-subnet-${floor(count.index / local.subnets_per_vpc)}-${count.index % local.subnets_per_vpc}"
    AZ = data.aws_availability_zones.available.names[
      local.zone_indices[count.index % local.subnets_per_vpc]
    ]
  }
}

output "output" {

  value = {
    commaon_data = {

        vpc_id = aws_subnet.subnets

    #   vpc_id = aws_vpc.my_vpc[floor(count.index / local.subnets_per_vpc)].id

    #   cidr_block = "10.${floor(count.index / local.subnets_per_vpc)}.${count.index % local.subnets_per_vpc}.0/24"

    #   availability_zone = data.aws_availability_zones.available.names[
    #   local.zone_indices[count.index % local.subnets_per_vpc]]

    #   Name = "${local.project_name}-subnet-${floor(count.index / local.subnets_per_vpc)}-${count.index % local.subnets_per_vpc}"
      
    #   AZ = data.aws_availability_zones.available.names[
    #     local.zone_indices[count.index % local.subnets_per_vpc]
    #   ]

    }


  }
}
