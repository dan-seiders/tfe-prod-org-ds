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
