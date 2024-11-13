locals {
  team_workspace_access_map = length(var.team_access) != null ? { for team in var.team_access : team.name => team } : {}
}

resource "tfe_workspace" "this" {
  organization = var.organization
  project_id   = var.project_id
  name         = var.name
  description  = var.description
  tag_names    = var.tag_names
  auto_apply   = var.auto_apply
}

resource "tfe_team_access" "workspace" {
  for_each = local.team_workspace_access_map

  access       = each.value.access
  team_id      = var.all_org_teams[each.key].id
  workspace_id = tfe_workspace.this.id
}

resource "tfe_workspace_variable_set" "workspace_varset" {
  for_each = toset(var.variable_sets)

  workspace_id    = tfe_workspace.this.id
  variable_set_id = var.org_variable_sets[each.value].id
}

