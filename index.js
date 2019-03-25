'use strict';

require('dotenv').config();

const Hapi = require('hapi');

const Server = Hapi.server({
  host: process.env.HOST,
  port: process.env.PORT
});

const goodOptions = {
  ops: {
    interval: 1000
  },
  reporters: {
    consoleReporter: [{
      module: 'good-squeeze',
      name: 'Squeeze',
      args: [{log: '*', response: '*', error: '*', request: '*'}]
    }, {
      module: 'good-console'
    }, 'stdout']
  }
};

(async () => {

  await Server.register([{
    plugin: require('inert'),
    options: {}
  }, {
    plugin: require('./routes'),
    options: {}
  }, {
    plugin: require('blipp'),
    options: {}
  }, {
    plugin: require('vision'),
    options: {}
  }, {
    plugin: require('lout'),
    options: {}
  }, {
    plugin: require('good'),
    options: goodOptions
  }]);

  await Server.start();
})();

process.on('unhandledRejection', (err) => {

  /* $lab:coverage:off$ */
  console.log(err);
  process.exit(1);
  /* $lab:coverage:on$ */
});

module.exports = Server;
