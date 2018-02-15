noflo = require 'noflo'

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'My looper'
  c.icon = 'stethoscope'
  
  c.inPorts.add 'end',
  	datatype: 'object'
  c.inPorts.add 'signal',
  	datatype: 'object',
    
  c.outPorts.add 'pass',
  	datatype: 'object'  
  c.outPorts.add 'stop',
  	datatype: 'object' 
    
  firstTime = true
  loopEnd = -1
  currI = 0
    
  c.process (input, output, context) ->
    
    if firstTime
      return unless input.hasData 'end'
      end = input.getData('end')
      loopEnd = end
      firstTime = false
    else
      return unless input.hasData 'signal'

    signal = input.get 'signal'
    
    if currI < loopEnd
      currI++
      output.sendDone
        pass: signal
    else
      output.sendDone
        stop: signal
