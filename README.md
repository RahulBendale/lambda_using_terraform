# lambda_using_terraform
Lambda with python code deploy on aws using Terraform 

Step 1: terraform init

Step 2: Terraform Plan

Step 3: terraform apply


Explanation in detail:

in terraform plan we can see following resources will get created:
1. iam_for_lambda_role: iam_for_lambda_role Role get created with Security Trust Policy with below json
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

2. Lambda function created with name: python_terraform_lambda

Total resources created after terraform apply command.
Apply complete! **Resources: 2 added,** 0 changed, 0 destroyed.
