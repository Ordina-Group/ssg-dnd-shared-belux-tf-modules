variable "email" {
  type = string
}

variable "first_name" {
  type = string
}

variable "last_name" {
  type = string
}

variable "realm_id" {
  type = string
}

variable "username" {
  type = string
}

variable "group_ids" {
  type = list(string)
}

variable "initial_password" {
  type    = string
  default = null
}
