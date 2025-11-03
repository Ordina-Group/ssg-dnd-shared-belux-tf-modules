resource "keycloak_user" "user" {
  attributes       = {}
  email            = var.email
  email_verified   = true
  enabled          = true
  first_name       = var.first_name
  last_name        = var.last_name
  realm_id         = var.realm_id
  required_actions = []
  username         = var.username
}

resource "keycloak_user_groups" "groups" {
  realm_id = var.realm_id
  user_id  = keycloak_user.user.id

  group_ids = var.group_ids
}
