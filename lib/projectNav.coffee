# find the root for whatever project you're working in
fs = require 'fs'
{dirname, existsSync, join} = require 'path'

exports.projectRoot = root = (dirname(dir) for dir in require.main.paths when existsSync(dir))[0]
exports.domainRoot = join root, 'domain'
exports.buildRoot = join root, 'build'

# walks a directory structure and calls callback on each file
exports.walkPath = walkPath = (path, pattern, callback) ->

  errCheck = (err, path) ->
    throw err if err and err.code isnt 'ENOENT'
    if err?.code is 'ENOENT'
      console.error "File not found: #{path}"
    return err?

  fs.stat path, (err, stats) ->
    return if errCheck(err, path)

    # get files in directory
    if stats.isDirectory()
      fs.readdir path, (err, files) ->
        errCheck(err, path)

        # recurse for each file
        for file in files
          file = join path, file
          walkPath file, pattern, callback

    # execute callback on file
    else if path.match pattern
      callback path

