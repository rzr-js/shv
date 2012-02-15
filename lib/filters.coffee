module.exports =
  pre: (coffee) ->
    cs = require 'coffee-script'
    cs.compile coffee

