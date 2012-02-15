build = () ->

  # get domain root and build root
  {domainRoot, buildRoot} = require './projectRoot'

  # compile all files in domain
  {exec} = require 'child_process'
  console.log "coffee -co #{buildRoot} #{domainRoot}"
  exec "coffee -co #{buildRoot} #{domainRoot}", (err, stdout, stderr) ->
    throw err if err

module.exports = build
build()
