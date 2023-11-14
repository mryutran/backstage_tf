module "aws_vpc" {
  source         = "./modules/vpc"
  project        = var.project
  vpc_cidr_block = var.vpc_cidr_block
  public_subnets = var.public_subnets
}

module "aws_s3" {
  source     = "./modules/s3"
  project    = var.project
  name       = var.name
}

module "aws_iam" {
  source  = "./modules/iam"
  project = var.project
}