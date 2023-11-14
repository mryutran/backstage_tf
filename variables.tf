variable project {
  type = string
}

variable vpc_cidr_block {
  type = string
}

variable "public_subnets" {
  type    = list(string)
  default = ["172.30.0.0/20", "172.30.16.0/20"]
}

variable name {
  type = string
}