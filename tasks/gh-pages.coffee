async = require 'async'
fs = require 'fs'
git = require 'gift'
ncp = require('ncp').ncp
path = require 'path'


module.exports = (grunt) ->
  grunt.registerMultiTask 'gh-pages', ' ', ->
    done = do (callback = @async()) ->
      (err) ->
        if err? and not (err instanceof Error)
          err = new Error(err)
        callback(err)

    options = @options(
      msg: 'Deployed at <%= grunt.template.today() %>'
      branch: 'gh-pages'
    )

    repo = git '.'

    async.waterfall([
      # Checkout the branch to deploy to
      repo.checkout.bind(repo, options.branch)

      # Copy files from build directory to root directory
      (stdout, message, callback) ->
        grunt.log.write(message)
        ncp(options.src, '.', callback)

      # Track all files
      repo.add.bind(repo, '.')

      # Commit changes
      (stdout, stderr, callback) ->
        grunt.log.writeln('Tracking all files')
        message = grunt.template.process(options.msg)
        grunt.log.writeln(message)
        repo.commit(message, {}, callback)

      # Push to remote if set
      (callback) ->
        if options.remote?
          repo.remote_push([options.remote, options.branch], callback)
        else
          callback()
      ],
      done
    )
