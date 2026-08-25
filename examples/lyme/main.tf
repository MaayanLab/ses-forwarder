provider "aws" {
  alias = "lambda"
}

provider "aws" {
  alias = "route53"
}

module "ses" {
  providers = { aws = aws, aws.route53 = aws.route53 }

  source = "github.com/schubergphilis/terraform-aws-mcaf-ses"
  domain = "ihdh.io"
  tags   = {}
}

module "ses-forwarder" {
  providers = { aws = aws, aws.lambda = aws.lambda }

  source      = "../.."
  bucket_name = "lyme-email-forwarding"
  tags        = {}
  ses_rule_set_name = "default-rule-set"
  ses_rule_name = "email-forwarding"
  create_ses_rule_set = false

  recipient_mapping = {
    "support@ihdh.io" = ["avi.maayan@mssm.edu", "anna.byrd@mssm.edu", "johnerol.evangelista@mssm.edu", "danieljbclarkemssm@gmail.com"]
  }
}
