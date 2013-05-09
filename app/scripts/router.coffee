define ['backbone', 'pages', 'chaos', 'maze'], (Backbone, pages, chaos, maze) ->

  Backbone.Router.extend

    routes:
      "": "switchPage"
      "maze": "maze"
      "chaos": "chaos"

    switchPage: (callback) ->
      this._activateHeaderLink()
      pages.load(callback)

    chaos: ->
      this.switchPage ->
        chaos.run()

    maze: ->
      this.switchPage ->
        maze.run()

    _activateHeaderLink: ->
      fragment = location.hash || "#"
      $(".nav > li").removeClass("active")
      $(".nav a[href='#{fragment}']").parent().addClass("active")
