# DynamoDB Streams and AWS Lambda project

Reference: https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Streams.Lambda.Tutorial.html

This project implements the AWS tutorial integrating DynamoDB Streams and Lambda.

It creates a table named "BarkTable" that contains data stored by a social network "Woofer". Then, it creates a Lambda that processes INSERT events for new "barks" and logs the information. More important, it creates a event mapping between these two services.

After applying the Terraform configuration, you may test the Lambda by editing the payload with the AWS region and account ID and running
```
aws lambda invoke --function-name publishNewBark --payload file://payload.json --cli-binary-format raw-in-base64-out output.txt
```
The payload.json contains fake data and the output.txt should be populated with the message `Successfully processed 1 records.`.

You may also check the AWS Lambda console and see the CloudWatch logs for the outputs.

If everything looks good, test the event mapper with
```
aws dynamodb put-item \
    --table-name BarkTable \
    --item Username={S="John Doe"},Timestamp={S="2016-11-18:14:32:17"},Message={S="Testing...1...2...3"}
```
Again, check the CloudWatch logs for the message.