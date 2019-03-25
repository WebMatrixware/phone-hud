'use strict';

const { expect } = require('code');
const Lab = require('lab');
const { after, before, describe, it } = exports.lab = Lab.script();

const Server = require('../index.js');

describe('functional test', () => {

  it('should return 200 on default route', async () => {

    const response = await Server.inject({
      method: 'GET',
      url: '/'
    });

    expect(response.statusCode).to.equal(200);
  });
});
