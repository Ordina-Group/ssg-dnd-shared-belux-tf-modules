variable "provider_name" {
  type    = string
  default = "mysql.shared"
}

variable "character_set" {
  type    = string
  default = null
}

variable "collation" {
  type    = string
  default = null
}

locals {
  db_namespace = replace(var.provider_name, ".", "-")
}
