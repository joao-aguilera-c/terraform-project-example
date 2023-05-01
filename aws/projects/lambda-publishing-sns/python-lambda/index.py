import boto3
import os

TopicArn = os.environ['SNS_TOPIC_ARN']


def lambda_handler(event, context):
    sns = boto3.client('sns')
    sns.publish(
        TopicArn=TopicArn,
        Message='Hello World!'
    )
    print('Message published to the topic %s' % TopicArn)