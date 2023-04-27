import requests

import boto3
import logging
import time
import os

# Configure AWS SDK
region_name = os.environ['AWS_DEFAULT_REGION']
session = boto3.Session(region_name=region_name)
logs_client = session.client('logs')

# Define log group and stream names
log_group_name = os.environ['LOG_GROUP_NAME']
log_stream_name = os.environ['LOG_STREAM_NAME']

def put_log_event(log_message):
    response = logs_client.put_log_events(
        logGroupName=log_group_name,
        logStreamName=log_stream_name,
        logEvents=[
            {
                'timestamp': int(round(time.time() * 1000)),
                'message': log_message
            }
        ]
    )

    # Print the log response
    logging.info(response)


def lambda_handler(event, context):
    put_log_event('Hello, world!')

    response = requests.get("https://www.google.com")
    put_log_event(response.status_code)