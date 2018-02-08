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
    
    allEvents = window.g[0]
    blocked = []
	blocked.push bsync.block for bsync in allEvents when bsync.block?
      
    possibleEvents = []
	possibleEvents.push bsync.request for bsync in allEvents when bsync.request? #
      and bsync.request not in blocked
    
    # need to handle case where there are no possible events
    nextEvent = possibleEvents[0]
    
    # need to add the call to the callbacks
    console.log("d",d)
    console.log("d",d.request) if d?
    d.callback("addhot") if d?
    output.sendDone
    	out: data
    
