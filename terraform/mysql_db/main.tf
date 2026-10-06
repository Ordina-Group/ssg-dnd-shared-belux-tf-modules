resource "random_password" "db_password" {
  length           = 32
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "random_password" "db_password_versioned" {
  count            = var.pass_version != null ? 1 : 0
  length           = 32
  special          = true
  override_special = "!#$&*()-_=+[]{}<>:?"
  keepers = {
    version = var.pass_version
  }
}

module "db_password_secret" {
  source  = "terraform-aws-modules/secrets-manager/aws"
  version = "2.2.0"

  # Secret
  name                    = replace("${module.this.id}-mysql-user-password", "_", "-")
  description             = replace("${module.this.id} mysql password", "_", "-")
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
  secret_string = var.pass_version != null ? random_password.db_password_versioned[0].result : random_password.db_password.result

  tags = {
    Resource = "Database"
  }
}


resource "mysql_database" "database" {
  name                  = module.this.name
  default_character_set = var.character_set
  default_collation     = var.collation
}

resource "mysql_user" "user" {
  user               = module.this.name
  host               = "%"
  plaintext_password = var.pass_version != null ? random_password.db_password_versioned[0].result : random_password.db_password.result
}

resource "mysql_grant" "ownership" {
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
