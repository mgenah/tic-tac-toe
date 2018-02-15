noflo = require 'noflo'

window.bsyncs = []

class Bsync
  constructor: (@request,@waitfor,@block,@callback) ->

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'bsync'
  c.icon = 'share'

  c.inPorts.add 'request',
  	datatype: 'string',
    control:true
    default: ""
  c.inPorts.add 'waitfor',
  	datatype: 'string',
    control: true,
    default: ""
  c.inPorts.add 'block',
  	datatype: 'string',
    control:true,
    default: ""
  c.inPorts.add 'signal',
  	datatype: 'bang'
  c.outPorts.add 'element',
  	datatype: 'object'

  c.process (input, output) ->
    return unless input.hasStream 'signal'
    return if input.attached('request').length and not input.hasData 'request'
    return if input.attached('waitfor').length and not input.hasData 'waitfor'
    return if input.attached('block').length and not input.hasData 'block'
    
    request = input.getData 'request'
    wait = input.getData 'waitfor'
    block = input.getData 'block'
    signal = input.get 'signal'

    scope = ""
    if signal != null
      scope = signal.scope
    
    if scope is "skip"
      console.log("**************skipping bsync**************")
      output.sendDone
      	element:scope
      return

    callback = (element) ->
      console.log("Callback called with element:", element)
      
      s = scope
      if element is scope
        console.log("Need to break upon event")
        s = "skip"
        totalBsyncs--
      o = new noflo.IP 'data', element,
      	scope: s

      output.send
        element:o
        
    if scope != null and scope != ""
      wait = scope
    
    bsync = new Bsync(request,wait,block,callback)
    console.log("Added new bsync object ", bsync)
    window.bsyncs.push(bsync)
    return
