resource "aws_lambda_function" "graffiti_monkey_lambda_function" {
  filename = "${var.function_zip}"
  function_name = "Graffiti_Monkey"
  description = "Lambda function to run Graffiti Monkey to tag EBS volumes with instance tags"
  role = "${aws_iam_role.tagging_lambda_iam_role.arn}"
  handler = "service.handler"
  source_code_hash = "${base64sha256(file(${var.function_zip}))}"
  runtime = "python2.7"
  timeout = "300"

  environment {
    variables = {
      REGION = "${var.aws_region}"
      INSTANCE_TAGS_TO_PROPAGATE = "Name,device,instance_id"
      VOLUME_TAGS_TO_PROPAGATE = "Name,device,instance_id"
      VOLUME_TAGS_TO_BE_SET = ""
      SNAPSHOT_TAGS_TO_BE_SET = ""
      INSTANCE_FILTER = ""
    }
  }

  tags = {
    Name = "Graffiti_Monkey"
  }
}

resource "aws_lambda_permission" "graffiti_monkey_lambda_permission" {
  statement_id = "AllowCloudWatchEventRuleInvokeScheduledTask"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.graffiti_monkey_lambda_function.function_name}"

  #qualifier     = "${aws_lambda_alias.graffiti_monkey_lambda_function_ops.name}"
  principal = "events.amazonaws.com"
  source_arn = "${aws_cloudwatch_event_rule.cloudwatch_event_rule_graffiti_monkey_run.arn}"
}
