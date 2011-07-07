# Server-side Code



exports.actions =
  
  init: (path, cb) ->   
    console.log path
     
    hash = path.slice 1, path.length
    SS.server.quicktok.get hash, (response) ->
      
      # If the hash has a valid sessionId associated with it, return it
      if response.sessionId?
        cb response
      else
        cb null
