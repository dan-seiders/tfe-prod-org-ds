terraform {
  required_version = "~>1.9.0"

  cloud {
    hostname     = "present-wallaby.dan-seiders.sbx.hashidemos.io"
    organization = "iac"

    workspaces {
      name = "org-setup"
    }
  }

  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.59.0"
    }
  }
}

provider "tfe" {
  hostname = "present-wallaby.dan-seiders.sbx.hashidemos.io"
}


output "workspaces" {
  value = module.iac_org.workspaces
}
