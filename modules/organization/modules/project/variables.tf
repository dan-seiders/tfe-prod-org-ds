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
    execution_mode = string
  })

  default = {
    execution_mode = "remote"
  }
}

variable "workspaces" {
  description = "The workspaces of the project."
  type = list(object({
    name         = string
    description  = string
    org_name     = string
    project_name = string
    tag_names    = list(string)
    auto_apply   = bool
  }))
}


# variable "name" {
#   description = "The name of the organization."
#   type        = string
# }

# variable "email" {
#   description = "The email address of the organization owner."
#   type        = string
# }

# variable "default_settings" {
#   description = "The default settings for the organization."
#   type = object({
#     execution_mode = string
#   })

#   default = {
#     execution_mode = "remote"
#   }
# }

# variable "teams" {

# }

# variable "projects" {

# }

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
