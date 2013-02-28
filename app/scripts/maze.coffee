define ['jquery', 'jquery-ui'], ($) ->
  ROWS = 25
  COLS = 40


  class Maze
    dx = [-1, 0,  1, 0]
    dy = [ 0, -1, 0, 1]

    constructor: (@rows, @cols) ->

    generate: ->
      @graph = {}
      @_edges = []
      this.addNode 0, 0
      while @_edges.length > 0
        index = Math.floor(Math.random() * @_edges.length)
        [row, col, dir] = @_edges.splice(index, 1)[0]
        this.addEdge row, col, dir
      @graph

    addNode: (row, col) ->
      @graph[row * @cols + col] = []
      for dir in [0..3]
        nrow = row + dx[dir]
        ncol = col + dy[dir]
        if nrow >= 0 and nrow < @rows and ncol >= 0 and ncol < @cols
          @_edges.push [row, col, dir]

    addEdge: (row, col, dir) ->
      nrow = row + dx[dir]
      ncol = col + dy[dir]
      if not (nrow * @cols + ncol of @graph)
        @graph[row * @cols + col].push [nrow, ncol]
        this.addNode nrow, ncol


  initializeMazeGrid = ->
    console.log 'something'
    for i in [0...ROWS]
      $('#maze-grid').append('<div class="maze-row wall-row"></div>')
        .append('<div class="maze-row"></div>');
    $('#maze-grid').append('<div class="maze-row wall-row"></div>')

    for i in [0...COLS]
      $('#maze-grid .maze-row').append('<div class="cell wall-col wall-cell"></div>')
        .append('<div class="cell"></div>')
    $('#maze-grid .maze-row').append('<div class="cell wall-col wall-cell"></div>')

    $('#maze-grid .wall-row .cell').addClass('wall-cell')
    $('#maze-grid .maze-row:nth-child(2)')
      .children('.cell:nth-child(2)').addClass('start')
    $("#maze-grid .maze-row:nth-child(#{2*ROWS})")
      .children(".cell:nth-child(#{2*COLS})").addClass('end')

  removeMazeWalls = (maze) ->
    for i, nodes of maze.graph
      row = Math.floor(i / COLS)
      col = i % COLS
      for [nrow, ncol] in nodes
        mazeRow = nrow + row + 2
        mazeCol = ncol + col + 2
        $('#maze-grid').children(":nth-child(#{mazeRow})")
          .children(":nth-child(#{mazeCol})")
          .removeClass('wall-cell')

  addDraggableMarker = ->
    $('.start').append('<div class="marker ui-widget-content"></div>')
    $('#maze-grid .marker').draggable()

    $('#maze-grid .wall-cell').droppable(
      over: (event, ui) ->
        $('.marker').remove();
        $('.start').append('<div class="marker ui-widget-content"></div>')
        $('#maze-grid .marker').draggable()
    )

    $('#maze-grid .end').droppable(
      drop: (event, ui) ->
        window.location.replace('http://www.youtube.com/watch?v=oHg5SJYRHA0')
    )


  run: ->
    return if @initialized
    @initialized = true

    maze = new Maze(ROWS, COLS)
    maze.generate()
    initializeMazeGrid()
    removeMazeWalls(maze)
    addDraggableMarker()
