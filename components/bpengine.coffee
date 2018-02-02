noflo = require 'noflo'

class Bsync
  constructor: (@request,@waitfor,@block,@callback) ->

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'BP engine'
  c.icon = 'share'

  c.inPorts.add 'in',
  	datatype: 'string'
  c.outPorts.add 'out',
  	datatype: 'object'  
  
  c.process (input, output, context) ->
    num for num in [1..1000]
    data = input.get 'in'
    #bsync.callback() for bsync in window.g
    d = window.g[0]
    console.log("d",d)
    console.log("d",d.request) if d?
    d.callback("addhot") if d?
    output.sendDone
    	out: data
    
