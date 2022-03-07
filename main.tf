locals {
  file_ext = var.format == "json" ? var.format : "y*ml"
  queries  = { for q in fileset(var.lacework_content_path, "queries/**/*.${local.file_ext}") : "${var.format == "json" ? jsondecode(file("${var.lacework_content_path}/${q}")).queryId : yamldecode(file("${var.lacework_content_path}/${q}")).queryId}" => "${var.format == "json" ? jsondecode(file("${var.lacework_content_path}/${q}")).queryText : yamldecode(file("${var.lacework_content_path}/${q}")).queryText}" }
  policies = { for p in fileset(var.lacework_content_path, "policies/**/*.${local.file_ext}") : "${var.format == "json" ? jsondecode(file("${var.lacework_content_path}/${p}")).policyId : yamldecode(file("${var.lacework_content_path}/${p}")).policyId}" => "${var.format == "json" ? jsondecode(file("${var.lacework_content_path}/${p}")) : yamldecode(file("${var.lacework_content_path}/${p}"))}" }
}
output "queries" {
  value = local.queries
}

output "policies" {
  value = local.policies
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

