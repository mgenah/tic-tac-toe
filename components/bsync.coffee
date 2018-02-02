noflo = require 'noflo'

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
    callback = (element) ->
      #x = () ->
        console.log("jjj")
        output.send
          element:element

      #return x
    request = input.getData 'request'
    wait = input.getData 'waitfor'
    block = input.getData 'block'
    bb = new Bsync(request,wait,block,callback)
    
    console.log(bb)
    window.g.push(bb)
    