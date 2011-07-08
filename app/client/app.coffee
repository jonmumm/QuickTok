# Client-side Code
window.qtok = {}

$(document).ready =>
  
  $("#copy-join-button").zclip(
    path: '/assets/ZeroClipboard.swf'
    copy: 'asdfasdfasdfas'
  )
  
  
  
  qtok.hash = SS.shared.hash.create()
  $("#link-input").val(document.location.href + qtok.hash)

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
      

      
    

