async = require 'async'
fs = require 'fs'
path = require 'path'
git = require 'gift'


module.exports = (grunt) ->
  grunt.registerMultiTask 'gh-pages', ' ', ->
    done = do (callback = @async()) ->
      (err) ->
        console.log(err)
        err = new Error(err) unless err instanceof Error
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
        mvFiles(options.src, '.', callback)

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

mvFiles = (src, dst, callback) ->
  fs.readdir src, (err, files) ->
    async.forEach(
      files,
      (file, callback) ->
        fs.rename(path.join(src, file), path.join(dst, file), callback)
      , callback
    )
