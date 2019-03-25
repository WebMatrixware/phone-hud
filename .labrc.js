module.exports = {
  coverage: true,
  threshold: 95,
  lint: true,
  colors: true,
  reporter: ['console', 'html', 'lcov'],
  output: ['stdout', './coverage/testoutput.html', './coverage/testoutput.lcov'],
  verbose: true,
  assert: 'code'
};
