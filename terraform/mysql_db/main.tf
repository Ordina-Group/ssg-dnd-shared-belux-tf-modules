resource "random_password" "db_password" {
  length           = 32
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

module "db_password_secret" {
  source = "terraform-aws-modules/secrets-manager/aws"

  # Secret
  name                    = "${module.this.id}-${local.db_namespace}"
  description             = "${local.db_namespace} ${module.this.tenant} password"
  recovery_window_in_days = 30

  # Policy
  create_policy       = false
  block_public_policy = true
  # policy_statements = {
  #   read = {
  #     sid = "AllowAccountRead"
  #     principals = [{
  #       type        = "AWS"
  #       identifiers = ["arn:aws:iam::1234567890:root"]
  #     }]
  #     actions   = ["secretsmanager:GetSecretValue"]
  #     resources = ["*"]
  #   }
  # }

  # Version
  secret_string = random_password.db_password.result

  tags = {
    Resource = "Database"
  }
}


resource "mysql_database" "database" {
  provider              = var.provider_name
  name                  = module.this.tenant
  default_character_set = var.character_set
  default_collation     = var.collation
}

resource "mysql_user" "user" {
  provider           = var.provider_name
  user               = module.this.tenant
  host               = "%"
  plaintext_password = random_password.db_password.result
}

resource "mysql_grant" "ownership" {
  provider = var.provider_name
  user     = mysql_user.user.user
  host     = mysql_user.user.host
  database = mysql_database.database.name
  privileges = [
    "SELECT",
    "INSERT",
    "UPDATE",
    "DELETE",
    "CREATE",
    "DROP",
    "INDEX",
    "ALTER",
    "CREATE TEMPORARY TABLES",
    "LOCK TABLES"
  ]
}
