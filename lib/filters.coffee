exports.filters = filters = [
  (callback, data) ->
    cs = require 'coffee-script'
    callback cs.compile data
]

curry = (fn, args...) ->
  -> fn args..., arguments...

exports.process = process = (data, callback) ->

  compose = (filters) ->
    [filter, filters...] = filters

    return callback unless filter

    return compose filters unless typeof filter == 'function'

    return curry filter, compose(filters)

  compose(filters)(data)



  # this should be a spec

  #fn1 = (data, callback) ->
    #cs = require 'coffee-script'
    #cs.compile data

  #fn2 = (data, callback) ->
    #m = require 'macros'
    #m.process data

  #fn1.apply(this, fn2.apply(this, callback))("foo")
