
# Fetch the current workspace name
locals {
  environment = terraform.workspace
  profile = local.environment == "production" ? "123_AdministratorAccess" : "456_AdministratorAccess"
}
