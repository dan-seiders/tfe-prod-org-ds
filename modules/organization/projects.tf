locals {
  projects    = [for filepath in var.projects : yamldecode(file(filepath))]
  project_map = { for project in local.projects : project.name => project }
}

resource "tfe_project" "this" {
  for_each = local.project_map

  organization = tfe_organization.this.name
  name         = each.value.name
  description  = each.value.description
}

module "projects" {
  source   = "./modules/project"
  for_each = local.project_map

  organization = tfe_organization.this.name
  name         = each.value.name
  description  = each.value.description
  config       = each.value.config
  workspaces   = each.value.workspaces
}

output "workspaces" {
  value = local.project_map
}
