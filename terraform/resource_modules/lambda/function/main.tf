provider "aws" {
  profile = "personal"
  region = var.aws_region
}

data "aws_iam_role" "role" {
  name = var.role_name
}

resource "aws_lambda_function" "lambda" {
  function_name = var.function_name
  handler = var.handler
  role = data.aws_iam_role.role.arn
  runtime = "python3.8"
  timeout = var.timeout
  memory_size = var.memory
  source_code_hash = filebase64sha256(var.lambda_src_location)

  environment {
    variables = {
      environment = var.environment
    }
  }

  tags = {
    project_name = "GularteCabinSharedCalendar"
    environment = var.environment
  }
}