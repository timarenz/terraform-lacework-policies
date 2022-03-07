locals {
  queries  = { for q in fileset(var.lacework_content_path, "queries/**/*.json") : jsondecode(file("${var.lacework_content_path}/${q}")).queryId => jsondecode(file("${var.lacework_content_path}/${q}")).queryText }
  policies = { for p in fileset(var.lacework_content_path, "policies/**/*.json") : jsondecode(file("${var.lacework_content_path}/${p}")).policyId => jsondecode(file("${var.lacework_content_path}/${p}")) }

}

resource "lacework_query" "main" {
  for_each = local.queries

  query_id = each.key
  query    = each.value
}

resource "lacework_policy" "main" {
  depends_on = [
    lacework_query.main
  ]

  for_each = local.policies

  title       = each.value.title
  description = each.value.description
  query_id    = each.value.queryId
  severity    = each.value.severity
  type        = each.value.policyType

  evaluation  = each.value.evalFrequency
  remediation = each.value.remediation
  limit       = each.value.limit
  enabled     = each.value.enabled

  alerting {
    profile = each.value.alertProfile
    enabled = each.value.alertEnabled
  }
}

