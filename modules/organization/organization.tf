locals {
  teams    = [for filepath in var.teams : yamldecode(file(filepath))]
  team_map = { for team in local.teams : team.name => team }

  all_users = flatten([for team in local.teams : [for member in team.members : member]])
}

resource "tfe_organization" "this" {
  name  = var.name
  email = var.email
}

resource "tfe_organization_default_settings" "this" {
  organization           = tfe_organization.this.name
  default_execution_mode = var.default_settings.execution_mode
}

resource "tfe_organization_membership" "this" {
  for_each     = toset(local.all_users)
  organization = tfe_organization.this.name
  email        = each.value
}

resource "tfe_team" "this" {
  for_each     = local.team_map
  organization = tfe_organization.this.name
  name         = each.value.name
}

resource "tfe_team_organization_members" "team_org_member" {
  for_each                    = local.team_map
  team_id                     = tfe_team.this[each.value.name].id
  organization_membership_ids = [for member in each.value.members : tfe_organization_membership.this[member].id]
}
