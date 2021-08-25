locals {
  lambda_function_filename = "s3bucketlambda.py"
  lambdafunction_name = "s3bucketlambda"
  handler_name = "s3bucketlambda.copy_object"
  output_file_location = "outputs/s3bucketlambda.zip"
}

# Archive a single file.
data "archive_file" "welcome" {
  type        = "zip"
  source_file = "s3bucketlambda.py"
  output_path = "outputs/s3bucketlambda.zip"
}

resource "aws_lambda_function" "lambda_function" {
  filename      = "outputs/s3bucketlambda.zip"
  function_name = "s3bucketlambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = "s3bucketlambda.copy_object"


  source_code_hash = filebase64sha256("outputs/s3bucketlambda.zip")

  runtime = "python3.7"

  #depends_on = [archive_file.welcome]
}

# Lambda function permission on s3 
resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.verizondemos3srcbucket.arn
}

