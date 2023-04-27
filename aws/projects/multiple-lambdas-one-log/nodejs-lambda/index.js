const lodash = require('lodash');
const winston = require('winston');
const AWS = require('aws-sdk');


// Configure AWS SDK
const region_name = process.env.AWS_DEFAULT_REGION;
const cloudwatchlogs = new AWS.CloudWatchLogs();

// Define log group and stream names
const log_group_name = process.env.LOG_GROUP_NAME;
const log_stream_name = process.env.LOG_STREAM_NAME;

const logger = winston.createLogger({
  level: 'info',
  format: winston.format.json(),
  transports: [
    new winston.transports.Console(),
    new winston.transports.File({ filename: 'app.log' })
  ]
});

async function put_log_event(log_message) {
  try {
    const response = await cloudwatchlogs.putLogEvents({
      logGroupName: log_group_name,
      logStreamName: log_stream_name,
      logEvents: [
        {
          timestamp: new Date().getTime(),
          message: log_message,
        },
      ],
    }).promise();

    logger.info(response);
  } catch (error) {
    logger.error(error, error.stack);
    throw error;
  }
}

exports.lambda_handler = async (event) => {
  await put_log_event('Hello world!');
  logger.info('Hello world!');

  const message = lodash.camelCase('Hello World');
  await put_log_event(message);
  logger.info(message);
};