var EmberApp = require('ember-cli/lib/broccoli/ember-app');

module.exports = function(defaults) {
  var app = new EmberApp(defaults, {
    'sassOptions': {
      extension: 'scss'
    },
    'ember-font-awesome': {
      useScss: true
    }
  });

  return app.toTree();
};
