resource "azuread_application" "saml" {
  display_name     = var.display_name
  identifier_uris  = var.identifier_uris
  sign_in_audience = "AzureADMyOrg"
}

resource "azuread_service_principal" "saml_sp" {
  client_id                     = azuread_application.saml.client_id
  homepage_url                  = var.homepage_url
  preferred_single_sign_on_mode = "saml"
}

resource "azuread_service_principal_token_signing_certificate" "saml_cert" {
  service_principal_id = azuread_service_principal.saml_sp.id
  display_name         = "CN=${var.display_name}"
}

resource "azuread_application_redirect_uris" "reply" {
  application_id = azuread_application.saml.id
  type           = "web"
  redirect_uris  = [var.reply_url]
}

output "service_principal_id" { value = azuread_service_principal.saml_sp.id }
