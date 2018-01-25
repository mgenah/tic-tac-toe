noflo = require 'noflo'
i=0

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'My Click Listener'
  c.icon = 'stethoscope'
  
  c.inPorts.add 'element',
  	datatype: 'object'
  c.outPorts.add 'element',
  	datatype: 'object'  
  
  c.process (input, output, context) ->
    return unless input.hasData 'element'
   
    element = input.getData 'element'
    console.log("2",element,window.g)
   
    listener = (event) ->
      window.g[i]()
      i++

    element.addEventListener 'click', listener