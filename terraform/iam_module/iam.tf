data "aws_iam_policy" "glue_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_iam_role" "glue_role" {
  name               = "GlueAssumeRole"
  assume_role_policy = data.aws_iam_policy.glue_policy.policy
}

resource "aws_iam_role" "s3_fullAccess" {
  name = "S3FullAccess"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "VisualEditor0",
        "Effect": "Allow",
        "Action": "s3:*",
        "Resource": "*"
      }
    ]
  })
}

resource "aws_iam_role" "s3_readOnly" {
  name = "S3ReadOnly"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
		{
			"Sid": "VisualEditor0",
			"Effect": "Allow",
			"Action": [
				"s3:GetObjectVersionTagging",
				"s3:GetStorageLensConfigurationTagging",
				"s3:GetObjectAcl",
				"s3:GetBucketObjectLockConfiguration",
				"s3:GetIntelligentTieringConfiguration",
				"s3:GetStorageLensGroup",
				"s3:GetAccessGrantsInstanceForPrefix",
				"s3:GetObjectVersionAcl",
				"s3:GetBucketPolicyStatus",
				"s3:GetAccessGrantsLocation",
				"s3:GetObjectRetention",
				"s3:GetBucketWebsite",
				"s3:GetJobTagging",
				"s3:GetMultiRegionAccessPoint",
				"s3:GetObjectAttributes",
				"s3:GetAccessGrantsInstanceResourcePolicy",
				"s3:GetObjectLegalHold",
				"s3:GetBucketNotification",
				"s3:DescribeMultiRegionAccessPointOperation",
				"s3:GetReplicationConfiguration",
				"s3:GetObject",
				"s3:DescribeJob",
				"s3:GetAnalyticsConfiguration",
				"s3:GetObjectVersionForReplication",
				"s3:GetAccessPointForObjectLambda",
				"s3:GetStorageLensDashboard",
				"s3:GetLifecycleConfiguration",
				"s3:GetAccessPoint",
				"s3:GetInventoryConfiguration",
				"s3:GetBucketTagging",
				"s3:GetAccessPointPolicyForObjectLambda",
				"s3:GetBucketLogging",
				"s3:GetAccessGrant",
				"s3:GetAccelerateConfiguration",
				"s3:GetObjectVersionAttributes",
				"s3:GetBucketPolicy",
				"s3:GetEncryptionConfiguration",
				"s3:GetObjectVersionTorrent",
				"s3:GetBucketRequestPayment",
				"s3:GetAccessPointPolicyStatus",
				"s3:GetAccessGrantsInstance",
				"s3:GetObjectTagging",
				"s3:GetMetricsConfiguration",
				"s3:GetBucketOwnershipControls",
				"s3:GetBucketPublicAccessBlock",
				"s3:GetMultiRegionAccessPointPolicyStatus",
				"s3:GetMultiRegionAccessPointPolicy",
				"s3:GetAccessPointPolicyStatusForObjectLambda",
				"s3:GetDataAccess",
				"s3:GetBucketVersioning",
				"s3:GetBucketAcl",
				"s3:GetAccessPointConfigurationForObjectLambda",
				"s3:GetObjectTorrent",
				"s3:GetMultiRegionAccessPointRoutes",
				"s3:GetStorageLensConfiguration",
				"s3:GetAccountPublicAccessBlock",
				"s3:GetBucketCORS",
				"s3:GetBucketLocation",
				"s3:GetAccessPointPolicy",
				"s3:GetObjectVersion"
			],
			"Resource": "*"
		  }
	  ]
  })
}

output "iam_glue_role_arn" {
	value = aws_iam_role.glue_role.arn
}

output "iam_s3_full_access_role_arn" {
	value = aws_iam_role.s3_fullAccess.arn
}

output "iam_s3_read_only_role_arn" {
	value = aws_iam_role.s3_readOnly.arn
}