
resource "aws_iam_role" "lambda_role" {
name   = "Resume_Lambda_Function_Role1"
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

resource "aws_iam_policy" "iam_policy_for_lambda" {
 
 name         = "aws_iam_policy_for_terraform_aws_lambda_role1"
 path         = "/"
 description  = "AWS IAM Policy for managing aws lambda role"
 policy = <<END
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": [
       "logs:CreateLogGroup",
       "logs:CreateLogStream",
       "logs:PutLogEvents",
       "lambda:InvokeFunction",
       "dynamodb:GetItem",
        "dynamodb:UpdateItem"
     ],
     "Resource": "*",
     "Effect": "Allow"
   }
 ]
}
END
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
 role        = aws_iam_role.lambda_role.name
 policy_arn  = aws_iam_policy.iam_policy_for_lambda.arn
}

data "archive_file" "zip_the_python_code" {
type        = "zip"
source_dir  = "../python/"
output_path = "../python/updatevisitors.zip"
}

resource "aws_lambda_function" "terraform_lambda_func" {
filename                       = "../python/updatevisitors.zip"
function_name                  = "UpdateVisitors_Lambda_Function"
role                           = aws_iam_role.lambda_role.arn
handler                        = "updatevisitors.lambda_handler"
runtime                        = "python3.8"
depends_on                     = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}