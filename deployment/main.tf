provider "aws" {
  region = "ap-south-1"
}

# Define the IAM role with an assume role policy
resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "iam_for_lambda_role"
  }
}

data "archive_file" "lambda" {
    type = "zip"
    source_file = "${path.module}/../src/lambda.py"
    output_path = "lambda_function_src.zip"
}

resource "aws_lambda_function" "test_lambda_function" {
    function_name = "python_terraform_lambda"
    filename = "lambda_function_src.zip"
    role = aws_iam_role.iam_for_lambda.arn

    source_code_hash = data.archive_file.lambda.output_base64sha256

    runtime = "python3.10"
    handler = "lambda_handler"
}