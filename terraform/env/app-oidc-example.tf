# OIDC app (Web + SPA + Native)
module "oidc_app_example" {
  source = "../modules/app-registration"

  display_name  = "${local.name}-example"
  enable_web    = true
  enable_spa    = true
  enable_native = true

  web_redirect_uris = ["https://app.example.com/auth/callback"]
  web_logout_url    = "https://app.example.com/logout"

  spa_redirect_uris    = ["https://spa.example.com/auth/callback", "http://localhost:3000"]
  native_redirect_uris = ["myapp://auth", "http://localhost"]

  app_roles = [
    {
      value                = "Admin"
      display_name         = "Admin"
      description          = "Admins can manage the app"
      allowed_member_types = ["User", "Application"]
    },
    {
      value                = "User"
      display_name         = "User"
      description          = "Standard user"
      allowed_member_types = ["User"]
    }
  ]
}

# Groups + role assignments for the OIDC app
module "groups_oidc_example" {
  source       = "../modules/group-assign"
  app_sp_id    = module.oidc_app_example.service_principal_id
  app_role_map = module.oidc_app_example.app_role_map

  groups = [
    { display_name = "${local.name}-example-admins", description = "Admins", role = "Admin" },
    { display_name = "${local.name}-example-users",  description = "Users",  role = "User"  },
  ]
}

# Helpful outputs
output "oidc_example_client_id" {
  value = module.oidc_app_example.client_id
}

output "oidc_example_service_principal_id" {
  value = module.oidc_app_example.service_principal_id
}
