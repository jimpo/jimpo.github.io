require.config
  paths:
    backbone: '../components/backbone/backbone'
    bootstrap: '../components/sass-bootstrap/docs/assets/js/bootstrap'
    jquery: '../components/jquery/jquery'
    'jquery-ui': '../components/jquery-ui/ui/jquery-ui'
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

require ['jquery', 'backbone', 'router', 'bootstrap'], ($, Backbone, Router) ->
  appRouter = new Router
  Backbone.history.start()
