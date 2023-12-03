
#     # The configuration for the `remote` backend.
#     terraform {
#       backend "remote" {
#         # The name of your Terraform Cloud organization.
#         organization = "briankissler"
#
#         # The name of the Terraform Cloud workspace to store Terraform state files in.
#         workspaces {
#           name = "aws_resume_challenge_BackEnd"
#         }
#       }
#     }


terraform {
  /* required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.20"
    }
  } */

  backend "remote" {
         # The name of your Terraform Cloud organization.
         organization = "briankissler"

         # The name of the Terraform Cloud workspace to store Terraform state files in.
         workspaces {
           name = "aws_resume_challenge_BackEnd"
         }
       }

}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_role" "lambda_role" {
 name   = "terraform_aws_lambda_role"
 assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# IAM policy for logging from a lambda

resource "aws_iam_policy" "iam_policy_for_lambda" {

  name         = "aws_iam_policy_for_terraform_aws_lambda_role"
  path         = "/"
  description  = "AWS IAM Policy for managing aws lambda role"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

# Policy Attachment on the role.

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role        = aws_iam_role.lambda_role.name
  policy_arn  = aws_iam_policy.iam_policy_for_lambda.arn
}

# Generates an archive from content, a file, or a directory of files.

data "archive_file" "hello-world-Py" {
 type        = "zip"
 source_dir  = "${path.module}/python/"
 output_path = "${path.module}/python/hello-world-Py.zip"
}

# Create a lambda function 
# In terraform ${path.module} is the current directory.
resource "aws_lambda_function" "hello-world-Py" {
 filename                       = "${path.module}/python/hello-world-Py.zip"
 function_name                  = "hello-world-Py"
 role                           = aws_iam_role.lambda_role.arn
 handler                        = "hello-world-Py.lambda_handler"
 runtime                        = "python3.7"
 source_code_hash               = data.archive_file.hello-world-Py.output_base64sha256
 layers                         = [aws_lambda_layer_version.python37-requests-layer.arn]
 depends_on                     = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}


# Python requests layer
resource "aws_lambda_layer_version" "python37-requests-layer" {
    filename            = "layers/hello-world-Py-layer.zip"
    layer_name          = "hello-world-Py-layer"
    source_code_hash    = "${filebase64sha256("layers/hello-world-Py-layer.zip")}"
    compatible_runtimes = ["python3.7"]
}

output "teraform_aws_role_output" {
 value = aws_iam_role.lambda_role.name
}

output "teraform_aws_role_arn_output" {
 value = aws_iam_role.lambda_role.arn
}

output "teraform_logging_arn_output" {
 value = aws_iam_policy.iam_policy_for_lambda.arn
}

/* resource "aws_iam_role" "lambda_basic_exe" {
  
} */