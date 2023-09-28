# Define your AWS provider configuration
provider "aws" {
  region = "ap-south-1" # Change to your desired AWS region
}

# Create an IAM role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  # Attach policies with necessary permissions here
  # Example:
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

# Create the Lambda function
resource "aws_lambda_function" "my_lambda" {
  function_name = "my-lambda-function"
  handler = "index.handler" # Change this to your actual handler
  runtime = "nodejs16.x" # Change this to your desired Node.js runtime

  # Attach the IAM role created above
  role = aws_iam_role.lambda_role.arn

  # Specify your deployment package (e.g., a .zip file)
  filename = "demo.zip"
}

# Define any other AWS resources as needed (e.g., API Gateway, S3, etc.)
