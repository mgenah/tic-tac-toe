noflo = require 'noflo'

window.bsyncs = []
i = 1

class Bsync
  constructor: (@request,@waitfor,@block,@callback) ->

handleEvent = (bsync,ev) -> 
	# Handle only statements that have requested or waited for this event 
  return unless bsync? and (bsync.request? and bsync.request is ev) or (bsync.waitfor? and bsync.waitfor is ev)
  # First remove from bsync statements data structure
  index = window.bsyncs.indexOf(bsync)
  window.bsyncs.splice(index,1)
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
    return unless window.bsyncs.length > 0 and input.hasData('in')
    
    console.log("--------")
    console.log("bpengine invocation " + i + ":")
    i++
    
    # Get all bsync statements
    allEvents = []
    allEvents.push bsync for bsync in window.bsyncs

    # Collect all blocked events from the bsync statements
    blocked = []
    blocked.push bsync.block for bsync in allEvents when bsync.block?

    console.log("Blocked events:")
    console.log(event) for event in blocked

    # Possible events = requested / blocked
    possibleEvents = []
    possibleEvents.push bsync.request for bsync in allEvents when bsync.request? and bsync.request not in blocked

    console.log("Possible events:")
    console.log(event) for event in possibleEvents

    if possibleEvents.length == 0
      console.log("NO POSSIBLE EVENTS")
      console.log("--------")
      output.sendDone
      return
    
    # we might want to move this to a function - this is our Event Selection Strategy
    # Choose random value from possibleEvents.
    rand = Math.floor(Math.random() * possibleEvents.length)
    nextEvent = possibleEvents[rand]
    console.log("Next event chosen:",nextEvent)
    console.log("--------")
    handleEvent bsync,nextEvent for bsync in allEvents
	
    # print all left bsync statements
    #console.log("bsyncs:")
    #console.log(possibleEv) for possibleEv in window.bsyncs
    output.sendDone
    

