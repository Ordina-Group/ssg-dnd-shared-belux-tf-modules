terraform {
  required_version = ">= 1.1.0"

  required_providers {
    mysql = {
      source  = "petoju/mysql"
      version = "3.0.86"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "6.25.0"
    }
  }
}
