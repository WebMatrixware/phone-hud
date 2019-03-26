'use strict';

const customersHandlers = require('./handlers/customers.js');

module.exports = {
  register: async (server, options) => {
    server.route([{
      method: 'GET',
      path: '/{param*}',
      handler: {
        directory: {
          path: './html',
          redirectToSlash: true,
          index: true,
        }
      }
    }, {
      method: 'GET',
      path: '/customers',
      handler: customersHandlers.getCustomers
    }]);
  },
  name: 'routes',
  version: '0.1.0'
};
