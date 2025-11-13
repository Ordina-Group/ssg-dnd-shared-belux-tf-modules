variable "endpoint" {
  type = string
}

variable "admin_user" {
  type = string
}

variable "admin_password" {
  type      = string
  sensitive = true
}

variable "character_set" {
  type    = string
  default = null
}

variable "collation" {
  type    = string
  default = null
}
