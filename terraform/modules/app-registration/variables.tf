variable "display_name" {
  type        = string
  description = "Display name for the Azure AD application"
}

variable "enable_web" {
  type    = bool
  default = false
}

variable "web_redirect_uris" {
  type    = list(string)
  default = []
}

variable "web_logout_url" {
  type    = string
  default = null
}

variable "enable_spa" {
  type    = bool
  default = false
}

variable "spa_redirect_uris" {
  type    = list(string)
  default = []
}

variable "enable_native" {
  type    = bool
  default = false
}

variable "native_redirect_uris" {
  type    = list(string)
  default = []
}

variable "app_roles" {
  description = "List of app roles to create"
  type = list(object({
    value                = string
    display_name         = string
    description          = string
    allowed_member_types = list(string)
  }))
  default = []
}
