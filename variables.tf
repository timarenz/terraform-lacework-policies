variable "lacework_content_path" {
  type        = string
  description = "Path fo the Lacework content directory."
}

variable "format" {
  type        = string
  description = "File format used for the queries and policies, either YAML or JSON. (Default: YAML)"
  default     = "yaml"
}
