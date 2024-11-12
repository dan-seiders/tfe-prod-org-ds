variable "organization" {
  description = "The name of the organization."
  type        = string
}

variable "name" {
  description = "The name of the project."
  type        = string
}

variable "description" {
  description = "A description of the project."
  type        = string
}

variable "config" {
  description = "The configuration of the project."
  type = object({
    execution_mode = optional(string)
  })

  default = {
    execution_mode = "remote"
  }
}

variable "workspaces" {
  description = "The workspaces of the project."
  type = list(object({
    name        = string
    description = string
    tag_names   = list(string)
    auto_apply  = bool
  }))
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
