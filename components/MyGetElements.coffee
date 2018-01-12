noflo = require 'noflo'

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'MultiListen'
  c.icon = 'stethoscope'
  
  c.inPorts.add 'selector',
  	datatype: 'array'
  c.outPorts.add 'element',
  	datatype: 'object'  

  
  c.process (input, output, context) ->
    return unless input.hasData 'selector'
    selector = input.getData 'selector'
     
    for s in selector  
      f = '#a' + s
      console.log f
      el = document.querySelectorAll f
      unless el.length
        output.done new Error "No element matching '{#f}'"
        return
      for element in el
        output.send
          element:element
          
    output.done()
   
   