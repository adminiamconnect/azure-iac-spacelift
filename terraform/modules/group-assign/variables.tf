variable "groups" {
  type = list(object({
    display_name = string
    description  = string
    role         = string
  }))
}

variable "app_sp_id"    { type = string }
variable "app_role_map" { type = map(string) }

variable "extra_service_principals" {
  type    = list(string)
  default = []
}
