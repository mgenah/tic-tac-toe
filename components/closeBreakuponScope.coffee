noflo = require 'noflo'
  
exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Breakupon scope'
  c.icon = 'indent'

  c.inPorts.add 'in',
  	datatype: 'string'
  c.outPorts.add 'out',
  	datatype: 'object'
    #scoped: false
 
  c.process (input, output) ->
    data = input.get 'in'

    output.sendDone
      out: data