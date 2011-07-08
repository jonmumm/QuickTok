exports.init = () ->
  console.log 'landing'
  
  SS.server.quicktok.new (response) ->
    $("#link-input").val(response.url)