terraform {
  required_version = "~>1.9.0"

  cloud {
    hostname     = "some_tfe_hostname.domain"
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
  hostname = "some_tfe_hostname.domain"
}