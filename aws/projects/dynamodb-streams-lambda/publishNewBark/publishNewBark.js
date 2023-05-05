'use strict';

exports.handler = (event, context, callback) => {

  event.Records.forEach((record) => {
    console.log('Stream record: ', JSON.stringify(record, null, 2));

    if (record.eventName == 'INSERT') {
      var who = JSON.stringify(record.dynamodb.NewImage.Username.S);
      var when = JSON.stringify(record.dynamodb.NewImage.Timestamp.S);
      var what = JSON.stringify(record.dynamodb.NewImage.Message.S);
      var message = 'Woofer user ' + who + ' barked the following at ' + when + ':\n\n ' + what;
      console.log(message);
    }
  });
  callback(null, `Successfully processed ${event.Records.length} records.`);
};