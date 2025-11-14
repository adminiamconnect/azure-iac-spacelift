output "group_ids" {
  value = { for k, g in azuread_group.g : k => g.object_id }
}
