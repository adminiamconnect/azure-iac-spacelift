module "groups_oidc_example" {
  source       = "../modules/group-assign"
  app_sp_id    = module.oidc_app_example.service_principal_id   # ✅ now exported
  app_role_map = module.oidc_app_example.app_role_map           # ✅ now exported
  ...
}

output "oidc_example_service_principal_id" {
  value = module.oidc_app_example.service_principal_id          # ✅ now exported
}
