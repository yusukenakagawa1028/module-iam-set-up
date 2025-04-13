resource "aws_iam_role" "iam_set_up_role" {
  name = "iam-set-up-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "iam_set_up_policy" {
    name = "iam-set-up-policy"
    policy = jsonencode(
        {
            "Version": "2012-10-17",
            "Statement": [
                {
                "Sid": "AllowAllActions",
                "Effect": "Allow",
                "Action": "*",
                "Resource": "*"
                },
                {
                "Sid": "ExplicitDenyRootLevelActions",
                "Effect": "Deny",
                "Action": [
                    "iam:DeleteAccountPasswordPolicy",
                    "iam:UpdateAccountPasswordPolicy",
                    "iam:CreateAccountAlias",
                    "iam:DeleteAccountAlias",
                    "organizations:*",
                    "account:*",
                    "support:*",
                    "billing:*",
                    "aws-portal:*"
                ],
                "Resource": "*"
                }
            ]
        }
    )
}

resource "aws_iam_policy_attachment" "iam_set_up_attachment" {
  name       = "iam-set-up-attachment"
  roles      = [aws_iam_role.iam_set_up_role.name]
  policy_arn = aws_iam_policy.iam_set_up_policy.arn
}
