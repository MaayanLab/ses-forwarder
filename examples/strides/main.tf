provider "aws" {
  alias = "lambda"
}

provider "aws" {
  alias = "route53"
}

//module "ses" {
//  providers = { aws = aws, aws.route53 = aws.route53 }
//
//  source = "github.com/schubergphilis/terraform-aws-mcaf-ses"
//  domain = "cfde.cloud"
//  tags   = {}
//}

module "ses-forwarder" {
  providers = { aws = aws, aws.lambda = aws.lambda }

  source      = "../.."
  bucket_name = "cfde-email"
  tags        = {}
  ses_rule_set_name = "default-rule-set"
  ses_rule_name = "email-forwarding"
  create_ses_rule_set = false

  recipient_mapping = {
    "help@cfde.cloud" = [
      "mmaurya@ucsd.edu",
      "sherry.jenkins@mssm.edu",
      "danieljbclarkemssm@gmail.com",
      "JohnErol.Evangelista@mssm.edu",
      "avi.maayan@mssm.edu",
      "maayan.avi@gmail.com"
    ]
  }
}
