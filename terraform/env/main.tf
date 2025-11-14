locals { name = "${var.prefix}-id" }

module "oidc_app" {
  source = "../modules/app-registration"

  display_name  = "${local.name}-example"
  enable_web    = true
  enable_spa    = true
  enable_native = true

  web_redirect_uris = [
    "https://app.example.com/auth/callback",
  ]
  web_logout_url    = "https://app.example.com/logout"

  spa_redirect_uris = [
    "https://spa.example.com/auth/callback",
    "http://localhost:3000",
  ]

  native_redirect_uris = [
    "myapp://auth",
    "http://localhost"
  ]

  app_roles = [
    {
      value                = "Admin"
      display_name         = "Admin"
      description          = "Admins can manage the app"
      allowed_member_types = ["User","Application"]
    },
    {
      value                = "User"
      display_name         = "User"
      description          = "Standard user"
      allowed_member_types = ["User"]
    }
  ]
}

module "saml_app" {
  source = "../modules/saml-enterprise-app"

  display_name     = "${local.name}-saml-app"
  homepage_url     = "https://saml-app.example.com"
  reply_url        = "https://saml-app.example.com/saml/acs"
  identifier_uris  = ["urn:example:${local.name}:saml"]
}

module "groups" {
  source       = "../modules/group-assign"
  app_sp_id    = module.oidc_app.service_principal_id
  app_role_map = module.oidc_app.app_role_map

  groups = [
    { display_name = "${local.name}-admins", description = "Admins", role = "Admin" },
    { display_name = "${local.name}-users",  description = "Users",  role = "User"  },
  ]

  extra_service_principals = [
    module.saml_app.service_principal_id
  ]
}

output "oidc_app_client_id"            { value = module.oidc_app.client_id }
output "oidc_app_service_principal_id" { value = module.oidc_app.service_principal_id }
output "saml_sp_id"                    { value = module.saml_app.service_principal_id }
