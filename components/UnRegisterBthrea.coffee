noflo = require 'noflo'
  
exports.getComponent = ->
  c = new noflo.Component
  c.description = 'bthread un-registration'
  c.icon = 'pencil-square-o'

  c.inPorts.add 'in',
  	datatype: 'object'
  c.outPorts.add 'out',
  	datatype: 'object'
 
  c.process (input, output, context) ->
    data = input.get 'in'
    
    if window.totalB != undefined
      --window.totalB

    output.sendDone
      out: data