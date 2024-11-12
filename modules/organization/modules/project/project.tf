locals {
  workspaces_map = { for workspace in var.workspaces : workspace.name => workspace }
}

resource "tfe_project" "this" {
  organization = var.organization
  name         = var.name
}

resource "tfe_team_project_access" "this" {
  for_each = var.config.team_access

  access     = each.value.access
  team_id    = data.tfe_teams.this[each.key].id
  project_id = tfe_project.this.id
}

resource "tfe_workspace" "workspace" {
  for_each = local.workspaces_map

  organization = var.organization
  project_id   = tfe_project.this.id

  name        = each.value.name
  description = each.value.description
  tag_names   = each.value.tag_names
  auto_apply  = each.value.auto_apply
}

# resource "tfe_team_access" "team_workspace_access" {
#   for_each = { for access in local.org_workspace_access : "${access.org_name}.${access.project_name}.${access.name}.${access.team}" => access }

#   access       = each.value.access
#   team_id      = tfe_team.team["${each.value.org_name}.${each.value.team}"].id
#   workspace_id = each.value.workspace_prevent_destroy == true ? tfe_workspace.workspace_prevent_destroy["${each.value.org_name}.${each.value.project_name}.${each.value.name}"].id : tfe_workspace.workspace["${each.value.org_name}.${each.value.project_name}.${each.value.name}"].id
# }

# variable set
# variables
