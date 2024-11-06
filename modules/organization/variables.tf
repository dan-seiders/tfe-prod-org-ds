variable "name" {
  description = "The name of the organization."
  type        = string
}

variable "email" {
  description = "The email address of the organization owner."
  type        = string
}

variable "default_settings" {
  description = "The default settings for the organization."
  type = object({
    execution_mode = string
  })

  default = {
    execution_mode = "remote"
  }
}

variable "teams" {

}

variable "projects" {

}

# SHOULD THIS BE FROM GLOBAL VARIABLE SET?
# variable "vra_username" {
#   description = "vRA username"
#   type        = string
# }

# variable "vra_password" {
#   description = "vRA password"
#   type        = string
#   sensitive   = true
# }
