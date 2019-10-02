module "sns_topic" {
  source  = "terraform-aws-modules/sns/aws"
  version = "~> 2.0"

  name         = "Codepipeline-${var.name}-failures"
  display_name = "Codepipeline ${var.name}"

  tags = var.tags
}

resource "aws_cloudwatch_event_rule" "rule" {
  name        = "Codepipeline-${var.name}-failures"
  description = "Codepipeline-${var.name}-failures"

  event_pattern = <<PATTERN
{
  "source": [ "aws.codepipeline" ],
  "detail-type": [ "CodePipeline Action Execution State Change" ],
  "resources":[ "${var.codepipeline_arn}" ],
  "detail": { 
      "state": [ "FAILED" ] 
      }
}
PATTERN

  tags = var.tags
}

resource "aws_cloudwatch_event_target" "sns" {
  rule      = aws_cloudwatch_event_rule.rule.name
  target_id = "SendToSNS"
  arn       = module.sns_topic.this_sns_topic_arn
}

resource "aws_sns_topic_policy" "default" {
  arn    = module.sns_topic.this_sns_topic_arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
    resources = [module.sns_topic.this_sns_topic_arn]
  }
}
