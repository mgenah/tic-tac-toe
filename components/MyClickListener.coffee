noflo = require 'noflo'

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
    console.log element
   
    listener = (event) ->
      output.send
      	element: element

    element.addEventListener 'click', listener