# get domain root and build root
{join, dirname, exists, relative, basename} = require 'path'
fs = require 'fs'
{exec} = require 'child_process'
{domainRoot, buildRoot, walkPath} = require './projectNav'

compileDomain = (callback) ->
  extension = 'coffee'
  extensionChecker = new RegExp "\.#{extension}$"
  walkPath domainRoot, extensionChecker, (file) ->

    # determine output filename
    relPath = relative domainRoot, file
    baseName = basename relPath, extension
    buildPath = join buildRoot, baseName + 'js'

    # read input file
    fs.readFile file, 'utf8', (err, data) ->
      console.log "in: #{file}, out: #{buildPath}"

      exec "mkdir -p #{dirname buildPath}"

      # pass to callback function, save result
      callback data, (result) ->
        fs.writeFile buildPath, result

build = () ->

  # get filters
  filters = require './filters'

  # walk domain and execute filters
  compileDomain filters.process

module.exports = build
build()
