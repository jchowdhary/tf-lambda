# tf-lambda
terraform example of using lambda to copy object from 1 bucket to another s3 bucket and have a gz glue job on bucket 2
1.	Create a S3 bucket in the US region (bucket1) with retention  as 30 days.
2.	Trigger an S3 event when object (text file) is placed in the S3 (bucket1)
3.	Trigger a lambda function to move the file to another bucket (bucket2) when S3 event is received
4.	Create a glue Job to compress the bucket2's object with gz

NOTE: Provider.tf is not attached for security reasons.

Current Status: 
Steps 1-3 are completed. 
Because of code issue in Python for Lambda, src and dest buckets are hardcoded and also the file name "sample.txt" only.(Did not got a proper Python file for copying)

Step 4 is todo..
