## aws-codepipeline-sns
Create a cloudwatch rule and SNS topic for codepipeline failure notifications

## Usage

```hcl
module "myapp_codepipeline_sns" {
  source  = "github.com/globeandmail/aws-codepipeline-sns"
  version = "~> 1.0"

  name             = "my-app"
  codepipeline_arn = "arn:aws:codepipeline:REGION:ACCT:name-of-pipeline"
  tags = {
    Project = var.project_name
    Env     = var.env
  }
}
```

## Notes
You will have to manually add topic subscriptions, as Terraform is unable to generate a subscription ARN until after the email address has been confirmed.

The following AWS CLI example can be used to add a subscription
```sh
aws sns subscribe --topic-arn my-topic-ARN --protocol email --notification-endpoint email-address@example.com
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| name | The name to use for the SNS topic and cloudwatch rules and event target | string | n/a | yes |
| codepipeline\_arn | The codepipeline ARN for the cloudwatch rule | string | n/a | yes |
| tags | A mapping of tags to assign to the resource | map | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| cloudwatch\_event\_rule\_arn |  |
| cloudwatch\_event\_rule\_id |  |
| sns\_topic\_arn |  |

