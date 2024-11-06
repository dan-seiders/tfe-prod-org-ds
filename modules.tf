module "iac_org" {
  source = "./modules/organization"

  name  = "iac_v2"
  email = "org_owner@some.domain"

  default_settings = {
    execution_mode = "remote" # module will default to remote if no value is passed
  }

  teams    = fileset(path.root, "orgs/nonprod/teams/*.yml")
  projects = fileset(path.root, "orgs/nonprod/projects/*.yml")
}
