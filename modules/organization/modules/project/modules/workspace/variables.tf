variable "organization" {
  description = "The name of the organization."
  type        = string
}

variable "name" {
  description = "The name of the workspace."
  type        = string
}

variable "project_id" {
  description = "The ID of the project the workspace is in."
  type        = string
}

variable "description" {
  description = "A description of the workspace."
  type        = string
}

variable "tag_names" {
  description = "A list of tag names for the workspace."
  type        = list(string)
}

variable "auto_apply" {
  description = "Whether to automatically apply changes to the workspace."
  type        = bool
}

variable "all_org_teams" {
  description = "All teams in the organization."
}

variable "team_access" {
  description = "The access settings for the workspace."
}

variable "variable_sets" {
  description = "The variable sets for the workspace."
}

variable "project_variable_sets" {
  description = "All available variable sets for the project."
}
