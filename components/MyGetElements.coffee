noflo = require 'noflo'


  
exports.getComponent = ->
  c = new noflo.Component
  c.description = 'MultiListen'
  c.icon = 'stethoscope'
  
  c.inPorts.add 'selector',
  	datatype: 'array'
  c.outPorts.add 'element',
  	datatype: 'object'  

  window.g = []
  
  c.process (input, output, context) ->
    return unless input.hasData 'selector'
    selector = input.getData 'selector'
    
    getVal = (element) ->
      x = () ->
        output.send
          element:element

      return x
     
    for s in selector  
      f = '#a' + s
      el = document.querySelectorAll f
      unless el.length
        output.done new Error "No element matching '{#f}'"
        return
      for element in el
        x = getVal(element)
        window.g.push(x)
  
