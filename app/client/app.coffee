# Client-side Code

# Bind to events
SS.socket.on 'disconnect', ->  $('#message').text('SocketStream server is down :-(')
SS.socket.on 'connect', ->     $('#message').text('SocketStream server is up :-)')

# This method is called automatically when the websocket connection is established. Do not rename/delete
exports.init = ->
  
  # User lands on a page  
  # Check if there is a hash at the end of the URL

  # Make a call to the server to retrieve a message
  SS.server.app.init (response) ->
    

