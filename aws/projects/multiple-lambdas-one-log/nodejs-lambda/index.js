const _ = require('lodash');

exports.lambda_handler = async (event) => {
  console.log('Hello world!');
  console.log(_.camelCase('Hello World'));
};