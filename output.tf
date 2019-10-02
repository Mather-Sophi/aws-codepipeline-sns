output "cloudwatch_event_rule_id" {
  value = aws_cloudwatch_event_rule.rule.id
}

output "cloudwatch_event_rule_arn" {
  value = aws_cloudwatch_event_rule.rule.arn
}


output "sns_topic_arn" {
  value = module.sns_topic.this_sns_topic_arn
}
