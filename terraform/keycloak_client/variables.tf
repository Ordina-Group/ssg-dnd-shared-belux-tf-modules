variable "admin_url" {
  type = string
}

variable "base_url" {
  type = string
}

variable "client_id" {
  type = string
}

variable "direct_access_grant_enabled" {
  type    = bool
  default = true
}

variable "name" {
  type = string
}

variable "realm_id" {
  type = string
}

variable "root_url" {
  type = string
}

variable "service_account_user_id" {
  type    = string
  default = null
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
  default = []
}

variable "web_origins" {
  type    = list(string)
  default = []
}
