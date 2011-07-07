# Client-side Code

# Bind to events
SS.socket.on 'disconnect', ->  $('#message').text('SocketStream server is down :-(')
SS.socket.on 'connect', ->     $('#message').text('SocketStream server is up :-)')

# This method is called automatically when the websocket connection is established. Do not rename/delete
exports.init = ->

  # Make a call to the server to retrieve a message
  SS.server.app.init window.location.pathname, (response) ->
    console.log response
    if response?
      SS.client.chat.init(response)
      $("#chat-wrapper").show('fast')
    else
      SS.client.landing.init()
      $("#landing-wrapper").show('fast')
      

      
    

