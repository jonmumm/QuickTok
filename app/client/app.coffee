# Client-side Code
window.qtok = {}

$(document).ready =>  
  qtok.hash = SS.shared.hash.create()
  $("#link-input").text(document.location.href + qtok.hash) 
  
  $("#link-input").click ->
    $("#link-input").select();
  
  $("#copy-button").zclip(
    path: '/assets/ZeroClipboard.swf'
    copy: $("#link-input").val()
    afterCopy: =>
      $("#copy-button").text "Copied"
  )
  
  $("#copy-join-button").zclip(
    path: '/assets/ZeroClipboard.swf'
    copy: $("#link-input").val()
    afterCopy: =>
      console.log 'hi'
  )

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
      

      
    

