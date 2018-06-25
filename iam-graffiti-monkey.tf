resource "aws_iam_role" "tagging_lambda_iam_role" {
  name = "TaggingLambdaRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "tagging_lambda_iam_role_policy" {
  name = "TaggingLambdaRolePolicy"
  role = "${aws_iam_role.tagging_lambda_iam_role.id}"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:DescribeLogStreams"
            ],
            "Resource": "arn:aws:logs:*:*:*"
        },
        {
            "Sid": "Stmt1495809202000",
            "Effect": "Allow",
            "Action": [
                "ec2:CreateTags",
                "ec2:DescribeSnapshots",
                "ec2:DescribeTags",
                "ec2:DescribeVolumes"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}
