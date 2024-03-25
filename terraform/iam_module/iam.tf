data "aws_iam_policy" "glue_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_iam_role" "glue_role" {
  name               = "GlueAssumeRole"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "glue.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "glue_policy_attachment" {
  name       = "GlueServiceRoleAttachment"
  roles      = [aws_iam_role.glue_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_iam_policy" "s3_full_access_policy" {
  name        = "S3FullAccessPolicy"
  description = "Policy to allow full access to the S3 bucket"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "s3:*",
        "Resource": ["*"]
      }
		]
	})
}

resource "aws_iam_policy_attachment" "s3_full_access_policy_attachment" {
  name       = "S3FullAccessPolicyAttachment"
  roles      = [aws_iam_role.glue_role.name]
  policy_arn = aws_iam_policy.s3_full_access_policy.arn
}
