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

variable "direct_access_grants_enabled" {
  type     = bool
  default  = true
  nullable = false
}

variable "name" {
  type    = string
  default = null
}

variable "realm_id" {
  type = string
}

variable "root_url" {
  type    = string
  default = null
}

variable "access_type" {
  type     = string
  default  = "CONFIDENTIAL"
  nullable = false
}

variable "service_accounts_enabled" {
  type     = bool
  default  = false
  nullable = false
}

variable "standard_flow_enabled" {
  type     = bool
  default  = true
  nullable = false
}

variable "valid_redirect_uris" {
  type    = list(string)
  default = null
}

variable "web_origins" {
  type    = list(string)
  default = null
}

variable "access_token_lifespan" {
  type    = string
  default = null
}

variable "client_secret" {
  type    = string
  default = null
}

variable "default_scopes" {
  type    = list(string)
  default = null
}

variable "optional_scopes" {
  type    = list(string)
  default = null
}
