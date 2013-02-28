require.config
  paths:
    jquery: '../components/jquery/jquery'
    bootstrap: 'vendor/bootstrap'
  shim:
    backbone:
      deps: ['underscore', 'jquery']
      exports: 'Backbone'
    bootstrap:
      deps: ['jquery']
      exports: 'jquery'
    underscore:
      exports: '_'


require ['jquery', 'app', 'bootstrap'], ($, app) ->
  console.log(app)
  console.log('Running jQuery %s', $().jquery)
