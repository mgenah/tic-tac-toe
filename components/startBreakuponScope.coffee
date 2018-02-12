noflo = require 'noflo'
  
exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Breakupon scope'
  c.icon = 'indent'

  c.inPorts.add 'request',
  	datatype: 'string'
  c.inPorts.add 'breakuponevent',
  	datatype: 'string'
    #control: true
  c.outPorts.add 'out',
  	datatype: 'object'
    #scoped: true
 
  c.process (input, output) ->
    return unless input.hasData 'request', 'breakuponevent'
    [data, scope] = input.getData 'request', 'breakuponevent'

    o = new noflo.IP 'data', data,
      	scope: scope
    console.log("IP:",o)
    output.sendDone
      out: o