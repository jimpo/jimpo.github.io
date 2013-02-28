define ['jquery', 'backbone', 'models/maze', 'jquery-ui'], ($, Backbone, Maze) ->

  Maze.View = Backbone.View.extend

    _initializeGrid: ->
      for i in [0...@model.rows]
        @$el.append('<div class="maze-row wall-row"></div>')
          .append('<div class="maze-row"></div>');
      @$el.append('<div class="maze-row wall-row"></div>')

      for i in [0...@model.cols]
        @$el.find('.maze-row').append('<div class="cell wall-col wall-cell"></div>')
          .append('<div class="cell"></div>')
      @$el.find('.maze-row').append('<div class="cell wall-col wall-cell"></div>')

      @$el.find('.wall-row .cell').addClass('wall-cell')
      @$el.find('.maze-row:nth-child(2)')
        .children('.cell:nth-child(2)').addClass('start')
      @$el.find(".maze-row:nth-child(#{2*@model.rows})")
        .children(".cell:nth-child(#{2*@model.cols})").addClass('end')

    _removeWalls: ->
      for i, nodes of @model.graph
        row = Math.floor(i / @model.cols)
        col = i % @model.cols
        for [nrow, ncol] in nodes
          mazeRow = nrow + row + 2
          mazeCol = ncol + col + 2
          @$el.children(":nth-child(#{mazeRow})")
            .children(":nth-child(#{mazeCol})")
            .removeClass('wall-cell')

    _addDraggableMarker: ->
      @$el.find('.start').append('<div class="marker ui-widget-content"></div>')
      @$el.find('.marker').draggable()

      @$el.find('.wall-cell').droppable(
        over: (event, ui) =>
          @$el.find('.marker').remove();
          @$el.find('.start').append('<div class="marker ui-widget-content"></div>')
          @$el.find('.marker').draggable()
      )

      @$el.find('.end').droppable(
        drop: (event, ui) ->
          window.location.replace('http://www.youtube.com/watch?v=oHg5SJYRHA0')
      )

    render: ->
      @$el.html('')
      this._initializeGrid()
      this._removeWalls()
      this._addDraggableMarker()
      this
