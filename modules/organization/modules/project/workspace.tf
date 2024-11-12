locals {
  workspaces_map = { for workspace in var.workspaces : workspace.name => workspace }
}
resource "tfe_project" "this" {
  organization = var.organization
  name         = var.name
}

resource "tfe_workspace" "workspace" {
  for_each = local.workspaces_map

  name         = each.value
  description  = each.value.description
  organization = each.value.org_name
  project_id   = tfe_project.this.id
  tag_names    = each.value.tag_names
  auto_apply   = each.value.auto_apply
}


# output "workspaces" {
#   value = flatten([for project in local.projects : [for workspace in project.workspaces : workspace]])
# }
