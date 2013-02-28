define ['jquery', 'models/maze', 'views/maze'], ($, Maze) ->
  ROWS = 25
  COLS = 40


  run: ->
    return if @initialized
    @initialized = true

    maze = new Maze(ROWS, COLS)
    mazeView = new Maze.View(model: maze, id: 'maze-grid')
    maze.generate()
    mazeView.render()
    $('#maze').append(mazeView.$el)
