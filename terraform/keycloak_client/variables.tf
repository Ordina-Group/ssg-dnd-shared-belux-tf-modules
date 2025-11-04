variable "admin_url" {
  type    = string
  default = null
}

variable "base_url" {
  type    = string
  default = null
}

variable "client_id" {
  type = string
}

variable "direct_access_grant_enabled" {
  type    = bool
  default = true
}

variable "name" {
  type    = string
  default = null
}

variable "realm_id" {
  type = string
}

variable "root_url" {
  type = string
}

variable "service_accounts_enabled" {
  type    = bool
  default = false
}

variable "standard_flow_enabled" {
  type    = bool
  default = true
}

variable "valid_redirect_uris" {
  type    = list(string)
  default = null
}

variable "web_origins" {
  type    = list(string)
  default = null
}
