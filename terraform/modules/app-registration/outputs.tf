output "application_id"       { value = azuread_application.app.id }
output "client_id"            { value = azuread_application.app.client_id }
output "service_principal_id" { value = azuread_service_principal.sp.id }
output "app_role_map"         { value = azuread_service_principal.sp.app_role_ids }
