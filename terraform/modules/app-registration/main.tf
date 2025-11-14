# Generate stable GUIDs for each app role (keyed by role value)
resource "random_uuid" "role_ids" {
  for_each = { for r in var.app_roles : r.value => r }
}

resource "azuread_application" "app" {
  display_name     = var.display_name
  sign_in_audience = "AzureADMyOrg"

  # OIDC platforms
  dynamic "web" {
    for_each = var.enable_web ? [1] : []
    content {
      homepage_url = var.web_logout_url != null ? replace(var.web_logout_url, "/logout$", "") : null
      redirect_uris = var.web_redirect_uris
      implicit_grant {
        access_token_issuance_enabled = true
        id_token_issuance_enabled     = true
      }
      logout_url = var.web_logout_url
    }
  }

  dynamic "single_page_application" {
    for_each = var.enable_spa ? [1] : []
    content {
      redirect_uris = var.spa_redirect_uris
    }
  }

  dynamic "public_client" {
    for_each = var.enable_native ? [1] : []
    content {
      redirect_uris = var.native_redirect_uris
    }
  }

  # Define app roles inline (each needs an explicit id)
  dynamic "app_role" {
    for_each = { for r in var.app_roles : r.value => r }
    content {
      id                   = random_uuid.role_ids[app_role.key].result
      value                = app_role.value.value
      display_name         = app_role.value.display_name
      description          = app_role.value.description
      allowed_member_types = app_role.value.allowed_member_types
      enabled              = true
    }
  }
}

# Keep a Service Principal for this application (needed by outputs and group assignments)
resource "azuread_service_principal" "sp" {
  client_id = azuread_application.app.client_id
}
