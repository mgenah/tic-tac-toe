noflo = require 'noflo'
  
exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Breakupon scope'
  c.icon = 'indent'

  c.inPorts.add 'request',
  	datatype: 'string'
  c.inPorts.add 'breakuponevent',
  	datatype: 'string'
  c.outPorts.add 'out',
  	datatype: 'object'
 
  c.process (input, output) ->
    return unless input.hasData 'request', 'breakuponevent'
    [data, scope] = input.getData 'request', 'breakuponevent'
    
    o = new noflo.IP 'data', data,
      	scope: scope
    output.sendDone
      out: o