locals {
  workspaces_map           = { for workspace in var.workspaces : workspace.name => workspace }
  team_project_access_map  = var.config.team_access != null ? { for team in var.config.team_access : team.name => team } : {}
  project_variable_set_map = length(var.config.variable_sets) > 0 ? { for variable_set in var.config.variable_sets : variable_set.name => variable_set } : {}
}

resource "tfe_project" "this" {
  organization = var.organization
  name         = var.name
}

resource "tfe_team_project_access" "this" {
  for_each = local.team_project_access_map

  access     = each.value.access
  team_id    = var.teams[each.key].id
  project_id = tfe_project.this.id
}

resource "tfe_variable_set" "this" {
  for_each = local.project_variable_set_map

  organization = var.organization
  name         = each.value.name
  description  = each.value.description
}

resource "tfe_project_variable_set" "this" {
  for_each = local.project_variable_set_map

  project_id      = tfe_project.this.id
  variable_set_id = tfe_variable_set.this[each.key].id
}

module "workspaces" {
  source   = "./modules/workspace"
  for_each = local.workspaces_map

  organization      = var.organization
  project_id        = tfe_project.this.id
  name              = each.value.name
  description       = each.value.description
  tag_names         = each.value.tag_names
  auto_apply        = each.value.auto_apply
  team_access       = try(each.value.team_access, {})
  variable_sets     = each.value.variable_sets
  org_variable_sets = tfe_variable_set.this

  all_org_teams = var.teams
}

# variable set
# variables
