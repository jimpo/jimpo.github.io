require.config
  paths:
    backbone: '../components/backbone/backbone'
    bootstrap: 'vendor/bootstrap'
    jquery: '../components/jquery/jquery'
    underscore: '../components/underscore/underscore'
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
