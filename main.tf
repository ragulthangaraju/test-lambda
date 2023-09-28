provider "aws" {
  region = "us-east-1" # Replace with your desired AWS region
}

resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_lambda_function" "example_lambda" {
  function_name = "example-lambda-function"
  handler = "index.handler" # Update with your actual handler
  runtime = "nodejs16.x"    # Update with your desired runtime

  role = aws_iam_role.lambda_execution_role.arn

  # Specify the path to your Lambda deployment package (ZIP file)
  filename = "demo.zip"

  # Optionally, you can configure environment variables, memory size, and timeout.
  environment {
    variables = {
      ENV_VAR1 = "value1",
      ENV_VAR2 = "value2"
    }
  }

  memory_size = 128
  timeout = 10
}
