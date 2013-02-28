define ['backbone', 'pages'], (Backbone, pages) ->

  Backbone.Router.extend

    routes:
      "": "switchPage"
      maze: "switchPage"
      chaos: "switchPage"

    switchPage: ->
      this._activateHeaderLink()
      pages.load()

    _activateHeaderLink: ->
      fragment = location.hash || "#"
      $(".nav > li").removeClass("active")
      $(".nav a[href=#{fragment}]").parent().addClass("active")
