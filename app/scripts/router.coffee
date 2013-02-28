define ['backbone'], (Backbone) ->

  Backbone.Router.extend

    routes:
      "": "home"
      maze: "maze"
      chaos: "chaos"

    home: ->
      this._activateHeaderLink()
      console.log("Displaying home page")

    maze: ->
      this._activateHeaderLink()
      console.log("Displaying maze page")

    chaos: ->
      this._activateHeaderLink()
      console.log("Displaying chaos page")

    _activateHeaderLink: ->
      fragment = location.hash || "#"
      $(".nav > li").removeClass("active")
      $(".nav a[href=#{fragment}]").parent().addClass("active")
