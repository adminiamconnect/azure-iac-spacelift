variable "tenant_id" {
  type = string
}

provider "azuread" {
  tenant_id            = var.tenant_id
  use_oidc             = true
  oidc_token_file_path = "/mnt/workspace/spacelift.oidc"
}
