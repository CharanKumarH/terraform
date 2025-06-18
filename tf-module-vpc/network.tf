provider "aws" {
  region = "ap-south-1"

}

data "aws_availability_zones" "available" {
  state = "available"
}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.21.0"

  name = "my_vpc"
  azs  = data.aws_availability_zones.available.names

  cidr            = "10.0.0.0/16"
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.2.0/24"]

  tags = {
    name = "my_vpc"
  }

}
output "name" {
  value = module.vpc.azs
}

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.8.0"

  name = "single-instance"

  instance_type          = "t2.micro"
  
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
    ami = "ami-0b09627181c8d5778" # "amazon-linux-2"
  tags = {
    name        = "my_instance"
    Environment = "dev"
  }
   
}