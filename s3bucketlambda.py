from __future__ import print_function
import boto3
import time, urllib
import json

print ("*"*80)
print ("Initializing..")
print ("*"*80)

s3 = boto3.client('s3')

def copy_object(event, context):
    # TODO implement
    source_bucket = "verizondemos3srcbucket"
    #https://verizondemos3srcbucket.s3.us-east-2.amazonaws.com/sample.txt event['Records'][0]['s3']['object']['key']
    object_key = "sample.txt" #urllib.unquote_plus(event['s3']['object']['key'])
    print("Object Key :", object_key)
    target_bucket = 'verizondemos3destbucket'
    copy_source = {'Bucket': source_bucket, 'Key': object_key}
    
    print ("Source bucket : ", source_bucket)
    print ("Target bucket : ", target_bucket)
    print ("Log Stream name: ", context.log_stream_name)
    print ("Log Group name: ", context.log_group_name)
    print ("Request ID: ", context.aws_request_id)
    print ("Mem. limits(MB): ", context.memory_limit_in_mb)
    
    try:
        print ("Using waiter to waiting for object to persist through s3 service")
        waiter = s3.get_waiter('object_exists')
        waiter.wait(Bucket=source_bucket, Key=object_key)
        s3.copy_object(Bucket=target_bucket, Key=object_key, CopySource=copy_source)
        return response['ContentType']
    except Exception as err:
        print ("Error -"+str(err))
        return e