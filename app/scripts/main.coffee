componentPaths = (components) ->
  for name, path of components
    components[name] = '../components/' + path
  components

require.config
  paths: componentPaths(
    backbone: 'backbone/backbone'
    bootstrap: 'sass-bootstrap/docs/assets/js/bootstrap'
    jquery: 'jquery/jquery'
    'jquery-ui': 'jquery-ui/ui/jquery-ui'
    underscore: 'underscore/underscore'
  )
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
