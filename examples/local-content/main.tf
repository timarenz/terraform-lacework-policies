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
  # source                = "git::https://github.com/timarenz/terraform-lacework-policies.git"
  source                = "../../"
  lacework_content_path = "${path.root}/content"
}
