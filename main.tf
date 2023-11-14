data "aws_ssm_parameter" "postgres_user" {
  name = "POSTGRES_USER"
}

data "aws_ssm_parameter" "postgres_password" {
  name = "POSTGRES_PASSWORD"
}

data "aws_ssm_parameter" "postgres_host" {
  name = "POSTGRES_HOST"
}


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

module "aws_alb" {
  source             = "./modules/alb"
  project            = var.project
  vpc_id             = module.aws_vpc.vpc_id
  subnet_ids         = values(module.aws_vpc.public_subnets)[*].id
  depends_on         = [module.aws_vpc]
}

module "aws_rds" {
  source                    = "./modules/rds"
  project                   = var.project
  storage                   = 20
  username                  = data.aws_ssm_parameter.postgres_user.value
  password                  = data.aws_ssm_parameter.postgres_password.value
  subnet_ids                = values(module.aws_vpc.private_subnets)[*].id
  vpc_id                    = module.aws_vpc.vpc_id
  default_security_group_id = module.aws_alb.default_security_group_id
  depends_on                = [module.aws_vpc, module.aws_alb]
}

resource "aws_ecr_repository" "registry" {
  name                 = "${var.project}-image"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}