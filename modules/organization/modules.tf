locals {
  projects    = [for filepath in var.projects : yamldecode(file(filepath))]
  project_map = { for project in local.projects : project.name => project }
}

module "projects" {
  source   = "./modules/project"
  for_each = local.project_map

  organization = tfe_organization.this.name
  name         = each.value.name
  description  = each.value.description
  config       = each.value.config
  workspaces   = each.value.workspaces
  teams        = tfe_team.this

  depends_on = [tfe_organization.this, tfe_team.this]
}
