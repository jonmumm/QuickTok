# Client-side Code
window.qtok = {}

$(document).ready =>  
  qtok.hash = SS.shared.hash.create()
  
  $("#link-input").text(document.location.href + qtok.hash)
  $("#success-url span").text(document.location.href + qtok.hash)

# This method is called automatically when the websocket connection is established. Do not rename/delete
exports.init = ->

  # Make a call to the server to retrieve a message
  SS.server.app.init window.location.pathname, (response) ->
    console.log response
    if response?
      SS.client.chat.init(response)
      $("#chat-wrapper").fadeIn('fast')
      
      $("#displayCurrUrlBtn").zclip(
        path: '/assets/ZeroClipboard.swf'
        copy: $("#displayCurrUrl").text()      
      )
    else
      SS.client.landing.init()
      $("#header-wrapper").fadeIn('fast')
      $("#landing-wrapper").fadeIn('fast')
      
      $("#api-link").click ->
        $("#landing-wrapper").hide('fast')
        $("#api-wrapper").show('fast')
        
      $("#videochat-link").click ->
        $("#api-wrapper").hide('fast')
        $("#landing-wrapper").show('fast')
        
      $("#help-link").click ->
        $("#api-wrapper").hide('fast')
        $("#landing-wrapper").show('fast')
        $("#help-wrapper").fadeIn('fast')
        setTimeout ->
          $("#help-wrapper").fadeOut('fast')
        , 2000
      
      $("#just-copy-button").zclip(
        path: '/assets/ZeroClipboard.swf'
        copy: $("#link-input").text()
        afterCopy: =>
          $("#links-wrapper").fadeOut 'fast', ->
            $("#copied-wrapper").fadeIn('fast')
      )
      

      $("#copy-join-button").zclip(
        path: '/assets/ZeroClipboard.swf'
        copy: $("#link-input").text()
        afterCopy: =>
          $("#copy-join-button").css('background-position', '0px -258px')
          SS.server.quicktok.reserve qtok.hash, (response) =>
            window.location = document.location.href + response.hash
      )
      

      
    

