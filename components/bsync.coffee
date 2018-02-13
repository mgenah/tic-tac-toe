noflo = require 'noflo'

window.bsyncs = []

class Bsync
  constructor: (@request,@waitfor,@block,@callback) ->

# sleepDuration = 100 milliseconds.
sleepDuration = 100

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'bsync'
  c.icon = 'share'

  c.inPorts.add 'request',
  	datatype: 'object'
  c.inPorts.add 'waitfor',
  	datatype: 'string'
  c.inPorts.add 'block',
  	datatype: 'string'
  c.outPorts.add 'element',
  	datatype: 'object'  
    
  firstInput = true
  outerRequest = null
  outerWait = ""
  outerBlock = ""
  
  sleep = (output) ->
    firstInput = false
    
    setTimeout ->
      innerProcess(output)
    , sleepDuration
  
  innerProcess = (output) ->        
    breakEvent = ""
    if outerRequest != null and outerRequest.scope != null
      console.log("scope: ", outerRequest.scope)
      breakEvent = outerRequest.scope
      
    if breakEvent is "skip"
      output.send
      	element:"skip"
      
    callback = (element) ->
      console.log("Callback called with element:", element)
      console.log("breakEvent:", breakEvent)
      o = breakEvent
      if element is breakEvent
        console.log("Need to break upon event")
        o= "skip"
        window.totalB--
      output.send
        element:o
    
    if breakEvent is ""
      breakEvent = outerWait
    
    bsyncReq = ""
    if outerRequest != null
      bsyncReq = outerRequest.data
    
    bsync = new Bsync(bsyncReq,breakEvent,outerBlock,callback)
    console.log("Added new bsync object ", bsync)
    window.bsyncs.push(bsync)
  
    firstInput = true
    outerRequest = null
    outerWait = ""
    outerBlock = ""
  c.process (input, output) ->
    return if input.hasData('request')==false and input.hasData('waitfor')==false and input.hasData('block')==false
    
    innerRequest = input.get 'request'
    innerWait = input.getData 'waitfor'
    innerBlock = input.getData 'block'
        
    if innerBlock=="" and innerWait=="" and (innerRequest.data=="")
      return
    
    if innerRequest != undefined and innerRequest != null
      outerRequest = innerRequest

    if innerWait != undefined
      outerWait = innerWait
      
    if innerBlock != undefined
      outerBlock = innerBlock
    
    if firstInput
      sleep(output)
      
    return
