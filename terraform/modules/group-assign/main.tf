resource "azuread_group" "g" {
  for_each         = { for g in var.groups : g.display_name => g }
  display_name     = each.value.display_name
  security_enabled = true
  description      = each.value.description
}

resource "azuread_app_role_assignment" "primary" {
  for_each = {
    for g in var.groups : g.display_name => {
      group_id = azuread_group.g[g.display_name].object_id
      role_id  = var.app_role_map[g.role]
    }
  }
  app_role_id         = each.value.role_id
  principal_object_id = each.value.group_id
  resource_object_id  = var.app_sp_id
}

# Optional: assign default 'User' role on extras (customize as needed)
resource "azuread_app_role_assignment" "extra_default" {
  for_each = { for sp in var.extra_service_principals : sp => sp }
  app_role_id         = try(var.app_role_map["User"], null)
  principal_object_id = azuread_group.g[values(var.groups)[0].display_name].object_id
  resource_object_id  = each.value

  lifecycle {
    ignore_changes = [app_role_id]
  }
}
