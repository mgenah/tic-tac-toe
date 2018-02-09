noflo = require 'noflo'

class Bsync
  constructor: (@request,@waitfor,@block,@callback) ->

handleEvent = (bsync,ev) -> 
	# Handle only statements that have requested or waited for this event 
  return unless bsync? and (bsync.request? and bsync.request is ev) or (bsync.waitfor? and bsync.waitfor is ev)
  console.log("bsync", bsync)
  # First remove from bsync statements data structure
  index = window.g.indexOf(bsync)
  window.g.splice(index,1)
  # Then call its callback
  bsync.callback(ev)	
    
exports.getComponent = ->
  c = new noflo.Component
  c.description = 'BP engine'
  c.icon = 'share'

  c.inPorts.add 'in',
  	datatype: 'string'
  c.outPorts.add 'out',
  	datatype: 'object'

  c.process (input, output, context) ->
    data = input.get 'in'
    
    console.log("bpengine:")
    return unless window.g.length > 0
    
    # Get all bsync statements
    allEvents = []
    allEvents.push bsync for bsync in window.g

    # Collect all blocked events from the bsync statements
    blocked = []
    blocked.push bsync.block for bsync in allEvents when bsync.block?

    console.log("Blocked events:")
    console.log(blockedev) for blockedev in blocked

    # Possible events = requested / blocked
    possibleEvents = []
    possibleEvents.push bsync.request for bsync in allEvents when bsync.request? and bsync.request not in blocked

    console.log("Possible events:")
    console.log(possibleEv) for possibleEv in possibleEvents

    if possibleEvents.length == 0
      output.sendDone
    # Choose next event
    
    # we might want to move this to a function - this is our Event Selection Strategy
    nextEvent = possibleEvents[0]
    console.log("Next event chosen:",nextEvent)
    handleEvent bsync,nextEvent for bsync in allEvents
	
    # print all left bsync statements
    console.log("g:")
    console.log(possibleEv) for possibleEv in window.g
    output.sendDone
    	out: data
    
