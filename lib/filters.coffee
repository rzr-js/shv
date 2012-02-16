filters =
  pre: (text) ->
    cs = require 'coffee-script'
    cs.compile text

  token: (token) -> token

  ast: (ast) -> ast

module.exports = filters
