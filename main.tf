module "aws_vpc" {
  source         = "./modules/vpc"
  project        = var.project
  vpc_cidr_block = var.vpc_cidr_block
  public_subnets = var.public_subnets
}

module "aws_s3" {
  source  = "./modules/s3"
  project = var.project
  name    = var.name
}

module "aws_iam" {
  source  = "./modules/iam"
  project = var.project
}

module "aws_ssm" {
  source               = "./modules/ssm"
  project              = var.project
  postgres_host        = var.rds_instance_endpoint
  postgres_user        = var.postgres_user
  postgres_password    = var.postgres_password
  github_token         = var.github_token
  github_client_id     = var.github_client_id
  github_client_secret = var.github_client_secret
  access_key_id        = var.access_key_id
  secret_access_key    = var.secret_access_key
}