noflo = require 'noflo'

window.bsyncs = []

class Bsync
  constructor: (@request,@waitfor,@block,@callback) ->

# sleepDuration = 1 second.
sleepDuration = 1000

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'bsync'
  c.icon = 'share'

  c.inPorts.add 'request',
  	datatype: 'string'
  c.inPorts.add 'waitfor',
  	datatype: 'string'
  c.inPorts.add 'block',
  	datatype: 'string'
  c.outPorts.add 'element',
  	datatype: 'object'  
    
  firstInput = true
  outerRequest = ""
  outerWait = ""
  outerBlock = ""
  
  sleep = (input, output, context) ->
    firstInput = false
    #console.log("sleep",request,wait,block)
    setTimeout ->
      innerProcess(input, output, context)
    , sleepDuration
  
  innerProcess = (input, output, context) ->
    #console.log("innerProcess! ", outerRequest, outerWait, outerBlock)
    
    callback = (element) ->
        console.log("Callback called with element:", element)
        output.send
          element:element
          
    bb = new Bsync(outerRequest,outerWait,outerBlock,callback)
    
    console.log("Added new bsync object ", bb)
    window.bsyncs.push(bb)
    
    firstInput = true
    outerRequest = ""
    outerWait = ""
    outerBlock = ""
  
  c.process (input, output, context) ->

    return if input.hasData('request')==false and input.hasData('waitfor')==false and input.hasData('block')==false
    
    innerRequest = input.getData 'request'
    innerWait = input.getData 'waitfor'
    innerBlock = input.getData 'block'
        
    if innerBlock=="" and innerWait=="" and innerRequest==""
      return
    
    if innerRequest != undefined
      outerRequest = innerRequest

    if innerWait != undefined
      outerWait = innerWait
      
    if innerBlock != undefined
      outerBlock = innerBlock
      
    if firstInput
      sleep(input, output, context)
      
    return
