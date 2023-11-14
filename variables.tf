variable "project" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "public_subnets" {
  type    = list(string)
  default = ["172.30.0.0/20", "172.30.16.0/20"]
}

variable "private_subnets" {
  type    = list(string)
  default = ["172.30.32.0/20", "172.30.64.0/20"]
}

variable "name" {
  type = string
}

variable "postgres_user" {
  type = string
}

variable "postgres_password" {
  type = string
}

variable "github_token" {
  type = string
}

variable "github_client_id" {
  type = string
}

variable "github_client_secret" {
  type = string
}

variable "access_key_id" {
  type = string
}

variable "secret_access_key" {
  type = string
}

variable "rds_instance_endpoint" {
  type = string
}
