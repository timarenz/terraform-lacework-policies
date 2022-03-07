terraform {
  required_providers {
    lacework = {
      source  = "lacework/lacework"
      version = "0.16.0"
    }
  }
}

provider "lacework" {}

module "lacework-policies-as-code" {
  source                = "git::https://github.com/timarenz/terraform-lacework-policies.git"
  lacework_content_path = "/Users/tim/Documents/lacework-content"
}
