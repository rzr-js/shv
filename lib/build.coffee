# get domain root and build root
{join, dirname, exists} = require 'path'
fs = require 'fs'
{exec} = require 'child_process'
{domainRoot, buildRoot, walkPath} = require './projectNav'

compileDomain = (callback) ->
  extension = 'coffee'
  extensionChecker = new RegExp "\.#{extension}$"
  walkPath domainRoot, extensionChecker, (file) ->

    # subtract domain from file path
    relPath = file[domainRoot.length..-(extension.length + 2)]
    buildPath = join buildRoot, relPath + '.js'

    # read file
    fs.readFile file, 'utf8', (err, data) ->
      console.log "in: #{file}\nout: #{buildPath}\ndata: #{data}"

      exec "mkdir -p #{dirname buildPath}"
      fs.writeFile buildPath, callback data

build = () ->

  # get filters
  filters = require './filters'

  # walk domain and execute filters
  compileDomain filters.pre

  # compile all files in domain
  #{exec} = require 'child_process'
  #console.log "coffee -co #{buildRoot} #{domainRoot}"
  #exec "coffee -co #{buildRoot} #{domainRoot}", (err, stdout, stderr) ->
    #throw err if err

module.exports = build
build()
