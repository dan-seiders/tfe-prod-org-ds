# /*
# data "tfe_team" "owners" {
#   for_each = {for org_key, org_value in local.layout.org : org_key => org_value}

#   organization = each.key
#   name         = "owners"
# }

# resource "tfe_team_members" "owners" {
#   for_each = {
#     for team in local.org_team : "${team.org_name}.${team.name}" => team
#     if team.name == "owners"
#   }

#   team_id   = data.tfe_team.owners["${each.value.org_name}.${each.value.name}"].id
#   usernames = each.value.members
# }
# */

# resource "tfe_workspace" "workspace_prevent_destroy" {
#   for_each = {
#     for workspace in local.org_workspace : "${workspace.org_name}.${workspace.project_name}.${workspace.name}" => workspace
#     if workspace.workspace_prevent_destroy == true
#   }

#   name         = each.value.name
#   description  = each.value.description
#   organization = each.value.org_name
#   project_id   = each.value.project_prevent_destroy == true ? tfe_project.project_prevent_destroy["${each.value.org_name}.${each.value.project_name}"].id : tfe_project.project["${each.value.org_name}.${each.value.project_name}"].id
#   tag_names    = each.value.tag_names
#   auto_apply   = each.value.auto_apply

#   lifecycle {
#     prevent_destroy = true
#   }
# }

# resource "tfe_workspace" "workspace" {
#   for_each = {
#     for workspace in local.org_workspace : "${workspace.org_name}.${workspace.project_name}.${workspace.name}" => workspace
#     if workspace.workspace_prevent_destroy == false
#   }

#   name         = each.value.name
#   description  = each.value.description
#   organization = each.value.org_name
#   project_id   = each.value.project_prevent_destroy == true ? tfe_project.project_prevent_destroy["${each.value.org_name}.${each.value.project_name}"].id : tfe_project.project["${each.value.org_name}.${each.value.project_name}"].id
#   tag_names    = each.value.tag_names
#   auto_apply   = each.value.auto_apply
# }

# resource "tfe_team_project_access" "team_project_access" {
#   for_each = { for access in local.org_project_access : "${access.org_name}.${access.name}.${access.team}" => access }

#   access     = each.value.access
#   team_id    = tfe_team.team["${each.value.org_name}.${each.value.team}"].id
#   project_id = each.value.project_prevent_destroy == true ? tfe_project.project_prevent_destroy["${each.value.org_name}.${each.value.name}"].id : tfe_project.project["${each.value.org_name}.${each.value.name}"].id
# }

# resource "tfe_team_access" "team_workspace_access" {
#   for_each = { for access in local.org_workspace_access : "${access.org_name}.${access.project_name}.${access.name}.${access.team}" => access }

#   access       = each.value.access
#   team_id      = tfe_team.team["${each.value.org_name}.${each.value.team}"].id
#   workspace_id = each.value.workspace_prevent_destroy == true ? tfe_workspace.workspace_prevent_destroy["${each.value.org_name}.${each.value.project_name}.${each.value.name}"].id : tfe_workspace.workspace["${each.value.org_name}.${each.value.project_name}.${each.value.name}"].id
# }

# resource "tfe_variable_set" "varset" {
#   for_each = { for variable_set in local.org_variable_set : "${variable_set.org_name}.${variable_set.name}" => variable_set }

#   name         = each.value.name
#   description  = each.value.description
#   organization = each.value.org_name

#   depends_on = [tfe_organization.org]
# }

# resource "tfe_project_variable_set" "project_varset" {
#   for_each = { for project in local.org_project_variable_set : "${project.org_name}.${project.project_name}.${project.name}" => project }

#   project_id      = each.value.project_prevent_destroy == true ? tfe_project.project_prevent_destroy["${each.value.org_name}.${each.value.project_name}"].id : tfe_project.project["${each.value.org_name}.${each.value.project_name}"].id
#   variable_set_id = tfe_variable_set.varset["${each.value.org_name}.${each.value.name}"].id
# }

# resource "tfe_workspace_variable_set" "workspace_varset" {
#   for_each = { for workspace in local.org_workspace_variable_set : "${workspace.org_name}.${workspace.project_name}.${workspace.workspace_name}.${workspace.name}" => workspace }

#   workspace_id    = each.value.workspace_prevent_destroy == true ? tfe_workspace.workspace_prevent_destroy["${each.value.org_name}.${each.value.project_name}.${each.value.workspace_name}"].id : tfe_workspace.workspace["${each.value.org_name}.${each.value.project_name}.${each.value.workspace_name}"].id
#   variable_set_id = tfe_variable_set.varset["${each.value.org_name}.${each.value.name}"].id
# }

# resource "tfe_variable" "variable_nonprod" {
#   for_each = {
#     for variable in local.org_variable_set_variable : "${variable.org_name}.${variable.variable_set_name}.${variable.key}" => variable
#     if variable.org_name == "nonprod"
#   }

#   key             = each.value.key
#   value           = each.value.key == "VRA_REFRESH_TOKEN" ? restapi_object.vra_refresh_nonprod.api_data.refresh_token : each.value.value
#   category        = each.value.category
#   description     = each.value.description
#   sensitive       = each.value.sensitive
#   variable_set_id = tfe_variable_set.varset["${each.value.org_name}.${each.value.variable_set_name}"].id

#   /*
#   lifecycle {
#     ignore_changes = [
#       value
#     ]
#   }
# */
# }

# resource "tfe_variable" "variable_prod" {
#   for_each = {
#     for variable in local.org_variable_set_variable : "${variable.org_name}.${variable.variable_set_name}.${variable.key}" => variable
#     if variable.org_name == "prod"
#   }

#   key             = each.value.key
#   value           = each.value.key == "VRA_REFRESH_TOKEN" ? restapi_object.vra_refresh_prod.api_data.refresh_token : each.value.value
#   category        = each.value.category
#   description     = each.value.description
#   sensitive       = each.value.sensitive
#   variable_set_id = tfe_variable_set.varset["${each.value.org_name}.${each.value.variable_set_name}"].id

#   /*
#   lifecycle {
#     ignore_changes = [
#       value
#     ]
#   }
# */
# }

# resource "restapi_object" "vra_refresh_nonprod" {
#   provider = restapi.vrapre

#   path         = "/csp/gateway/am/api/login"
#   query_string = "access_token"
#   id_attribute = "login"
#   object_id    = "login"
#   data = jsonencode({
#     "username" = var.vra_username,
#     "password" = var.vra_password
#   })
# }

# resource "restapi_object" "vra_refresh_prod" {
#   provider = restapi.vraprod

#   path         = "/csp/gateway/am/api/login"
#   query_string = "access_token"
#   id_attribute = "login"
#   object_id    = "login"
#   data = jsonencode({
#     "username" = var.vra_username,
#     "password" = var.vra_password
#   })
# }
