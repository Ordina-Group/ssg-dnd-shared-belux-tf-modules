variable "provider_name" {
  type    = string
  default = "mysql.shared"
}

locals {
  db_namespace = replace(var.provider_name, ".", "-")
}
