variable "tenant_id"       { type = string }
variable "subscription_id" { type = string }

provider "azurerm" {
  features {}
  use_oidc             = true
  oidc_token_file_path = "/mnt/workspace/spacelift.oidc"
  subscription_id      = var.subscription_id
}

provider "azuread" {
  tenant_id            = var.tenant_id
  use_oidc             = true
  oidc_token_file_path = "/mnt/workspace/spacelift.oidc"
}
