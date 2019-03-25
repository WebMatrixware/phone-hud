'use strict';

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
      handler: function(request, h) {
        return 'customers GET request';
      }
    }]);
  },
  name: 'routes',
  version: '0.1.0'
};
