module "aws_vpc" {
  source         = "./modules/vpc"
  project        = var.project
  vpc_cidr_block = var.vpc_cidr_block
  public_subnets = var.public_subnets
}