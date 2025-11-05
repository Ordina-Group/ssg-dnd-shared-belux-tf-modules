resource "keycloak_openid_client" "client" {
  access_token_lifespan                      = var.access_token_lifespan
  access_type                                = var.access_type
  admin_url                                  = var.admin_url != null ? var.admin_url : var.root_url
  backchannel_logout_revoke_offline_sessions = false
  backchannel_logout_session_required        = false
  backchannel_logout_url                     = null
  base_url                                   = var.base_url
  client_authenticator_type                  = "client-secret"
  client_id                                  = var.client_id
  client_offline_session_idle_timeout        = null
  client_offline_session_max_lifespan        = null
  client_session_idle_timeout                = null
  client_session_max_lifespan                = null
  client_secret                              = var.client_secret
  consent_required                           = false
  consent_screen_text                        = null
  description                                = null
  direct_access_grants_enabled               = var.direct_access_grants_enabled
  display_on_consent_screen                  = false
  enabled                                    = true
  extra_config                               = {}
  frontchannel_logout_enabled                = false
  frontchannel_logout_url                    = null
  full_scope_allowed                         = true
  implicit_flow_enabled                      = false
  import                                     = false
  login_theme                                = null
  name                                       = var.name != null ? var.name : var.client_id
  oauth2_device_authorization_grant_enabled  = false
  oauth2_device_code_lifespan                = null
  oauth2_device_polling_interval             = null
  realm_id                                   = var.realm_id
  root_url                                   = var.root_url
  service_accounts_enabled                   = var.service_accounts_enabled
  standard_flow_enabled                      = var.standard_flow_enabled
  use_refresh_tokens                         = false
  use_refresh_tokens_client_credentials      = false
  valid_post_logout_redirect_uris = [
    "+",
  ]
  valid_redirect_uris = var.valid_redirect_uris != null ? var.valid_redirect_uris : ["${trimsuffix(var.root_url, "/")}/*"]
  web_origins         = var.web_origins != null ? var.web_origins : [trimsuffix(var.root_url, "/")]
}

resource "keycloak_openid_client_default_scopes" "client_default_scopes" {
  count     = var.default_scopes != null ? 1 : 0
  realm_id  = var.realm_id
  client_id = keycloak_openid_client.client.id

  default_scopes = concat(var.default_scopes, (keycloak_openid_client.client.service_accounts_enabled ? ["service_account"] : []))
}

resource "keycloak_openid_client_optional_scopes" "client_optional_scopes" {
  count     = var.optional_scopes != null ? 1 : 0
  realm_id  = var.realm_id
  client_id = keycloak_openid_client.client.id

  optional_scopes = var.optional_scopes
}
