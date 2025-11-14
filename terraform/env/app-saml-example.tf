/*
 SAML 2.0 Enterprise App + its groups.
 Duplicate this file to add another SAML app (e.g., app-saml-hr.tf)
 and adjust the module names and values.
*/

module "saml_app_example" {
  source = "../modules/saml-enterprise-app"

  display_name     = "${local.name}-saml-app"
  homepage_url     = "https://saml-app.example.com"
  reply_url        = "https://saml-app.example.com/saml/acs"
  identifier_uris  = ["urn:example:${local.name}:saml"]
}

module "groups_saml_example" {
  source       = "../modules/group-assign"
  app_sp_id    = module.saml_app_example.service_principal_id
  # For SAML apps without custom roles, assign default 'User' if present
  app_role_map = { for k, v in module.oidc_app_example.app_role_map : k => v } # reuse map shape if needed

  groups = [
    { display_name = "${local.name}-saml-users", description = "SAML users", role = "User" }
  ]
}

output "saml_example_service_principal_id" { value = module.saml_app_example.service_principal_id }
