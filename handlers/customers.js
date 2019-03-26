'use strict';

exports.getCustomers = async (request, h) => {
  return h.response('customers').code(200);
};
