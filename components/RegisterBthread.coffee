noflo = require 'noflo'

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Register bthread'
  c.icon = 'pencil-square-o'

  c.inPorts.add 'in',
  	datatype: 'string'
  c.outPorts.add 'out',
  	datatype: 'object'
 
  c.process (input, output, context) ->
    data = input.get 'in'
    if window.totalBsyncs == undefined
      window.totalBsyncs = 1
    else
      ++window.totalBsyncs

    output.sendDone
      out: data