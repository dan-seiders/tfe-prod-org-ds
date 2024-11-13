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
    execution_mode  = optional(string)
    prevent_destroy = optional(bool)
    team_access = optional(list(object({
      name   = string
      access = string
    })))
    variable_sets = list(
      object({
        name        = optional(string)
        description = optional(string)
        category    = optional(string)
        sensitive   = optional(bool)
        hcl         = optional(bool)
        value       = optional(string)
    }))
    }
  )

  default = {
    execution_mode = "remote"
    team_access = [{
      name   = ""
      access = ""
    }]
    variable_sets = []
  }
}

variable "workspaces" {
  description = "The workspaces of the project."
}

variable "teams" {}
