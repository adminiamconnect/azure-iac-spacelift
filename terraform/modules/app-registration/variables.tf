variable "display_name" { type = string }

variable "enable_web"    { type = bool default = true }
variable "enable_spa"    { type = bool default = false }
variable "enable_native" { type = bool default = false }

variable "web_redirect_uris" { type = list(string) default = [] }
variable "web_logout_url"    { type = string      default = null }

variable "spa_redirect_uris"    { type = list(string) default = [] }
variable "native_redirect_uris" { type = list(string) default = [] }

variable "app_roles" {
  type = list(object({
    value                = string
    display_name         = string
    description          = string
    allowed_member_types = list(string)
  }))
  default = []
}
