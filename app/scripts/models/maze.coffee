define ['backbone'], (Backbone) ->
  dx = [-1, 0,  1, 0]
  dy = [ 0, -1, 0, 1]

  Backbone.Model.extend
    constructor: (@rows, @cols) ->
      Backbone.Model.call(this)

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
