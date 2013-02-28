define ['backbone'], (Backbone) ->

  Backbone.Router.extend

    routes:
      maze: "maze"

    maze: ->
      console.log("Displaying maze page")
