variable "name" {
  description = "The name to use for the SNS topic and cloudwatch rules and event target"
  type        = string
}

variable "codepipeline_arn" {
  description = "The codepipeline ARN for the cloudwatch rule"
  type        = string
}

variable "tags" {
  type        = map
  description = "A mapping of tags to assign to the resource"
  default     = {}
}
