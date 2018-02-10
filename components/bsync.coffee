noflo = require 'noflo'

window.bsyncs = []

class Bsync
  constructor: (@request,@waitfor,@block,@callback) ->

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
  
  c.process (input, output, context) ->

    return if input.hasData('request')==false and input.hasData('waitfor')==false and input.hasData('block')==false
    
    request = input.getData 'request'
    wait = input.getData 'waitfor'
    block = input.getData 'block'
  
    return if request=="" or wait =="" or block == ""
    
    callback = (element) ->
        console.log("Callback called with element:", element)
        output.send
          element:element
          
    bb = new Bsync(request,wait,block,callback)
    
    console.log("Added new bsync object ", bb)
    window.bsyncs.push(bb)
    
