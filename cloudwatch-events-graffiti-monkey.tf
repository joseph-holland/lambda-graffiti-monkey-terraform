resource "aws_cloudwatch_event_rule" "cloudwatch_event_rule_graffiti_monkey_run" {
  name = "LambdaGraffitiMonkeyRun"
  description = "Scheduled job to run Graffiti Monkey"
  schedule_expression = "cron(0 1 * * ? *)"
}

resource "aws_cloudwatch_event_target" "cloudwatch_event_target_graffiti_monkey" {
  rule = "${aws_cloudwatch_event_rule.cloudwatch_event_rule_graffiti_monkey_run.name}"
  arn = "${aws_lambda_function.graffiti_monkey_lambda_function.arn}"
}

