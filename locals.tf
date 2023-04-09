#we can use locals to substitute

locals {
  DOCDB_PASS = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["DOCDB_PASSWORD"]
  DOCDB_USER = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["DOCDB_USERNAME"]
}