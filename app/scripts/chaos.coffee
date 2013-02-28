define ['jquery'], ($) ->
  ROWS = 50
  COLS = 100
  ACTIVE_CLASS = 'alive'


  class CellularAutomaton

    constructor: (@rows, @cols, @grid) ->

    readCell: (i, j) ->
      @grid[i][j].hasClass(ACTIVE_CLASS)

    writeCell: (i, j) ->
      $cell = @grid[i][j]
      alive = @state[i][j]
      if alive and not $cell.hasClass(ACTIVE_CLASS)
        $cell.addClass(ACTIVE_CLASS)
      if not alive and $cell.hasClass(ACTIVE_CLASS)
        $cell.removeClass(ACTIVE_CLASS)

    readState: ->
      @state = ((this.readCell(i, j) for j in [0...@cols]) for i in [0...@rows])

    writeState: () ->
      ((this.writeCell(i, j) for j in [0...@cols]) for i in [0...@rows])

    iterateState: () ->
      @state = ((this.iterateCell(i, j) for j in [0...@cols]) for i in [0...@rows])


  class ConwaysLife extends CellularAutomaton

    neighbors: (row, col) ->
      deltas = [[-1, -1], [-1, 0], [-1, 1],
                [ 0, -1],          [ 0, 1],
                [ 1, -1], [ 1, 0], [ 1, 1]]
      normalize = (r, c) ->
        [(r + ROWS) % ROWS, (c + COLS) % COLS]
      normalize(row + dr, col + dc) for [dr, dc] in deltas

    iterateCell: (i, j) ->
      livingNeighbors = (true for [r, c] in this.neighbors(i, j) when @state[r][c])
      (livingNeighbors.length is 3) or (@state[i][j] and livingNeighbors.length is 2)


  initializeGrid = ->
    grid = []
    for i in [0...ROWS]
      row = []
      $row = $('<div class="grid-row"></div>')
      for j in [0...COLS]
        $cell = $('<div class="grid-cell"></div>')
        $row.append $cell
        row.push $cell
      $('#grid').append $row
      grid.push row
    grid

  toggle = ($cell) ->
    if $cell.hasClass(ACTIVE_CLASS)
      $cell.removeClass(ACTIVE_CLASS)
    else
      $cell.addClass(ACTIVE_CLASS)

  run: ->
    return if @initialized
    @initialized = true

    down = false
    running = false

    grid = initializeGrid()
    gameOfLife = new ConwaysLife(ROWS, COLS, grid)

    $('#grid').mousedown ->
      down = true
    $('#grid').mouseup ->
      down = false
    $('.grid-cell').mouseover ->
      if not running and down
        toggle $(this)
    $('.grid-cell').click ->
      if not running
        toggle $(this)

    $('#step').click ->
      gameOfLife.readState()
      gameOfLife.iterateState()
      gameOfLife.writeState()

    $('#run').click ->
      if running
        $(this).text 'Start'
        running = false
      else
        $(this).text 'Stop'
        gameOfLife.readState()
        running = true

    $('#clear').click ->
      if not running
        $('.grid-cell').removeClass(ACTIVE_CLASS)

    performIteration = ->
      if running
        gameOfLife.iterateState()
        gameOfLife.writeState()
    setInterval(performIteration, 100)
