/*
 Simple entry point.
 Terraform automatically loads all *.tf files in this folder.
 Add a new app by copying one of the app-*.tf files and editing values.
*/
locals { name = "${var.prefix}-id" }
