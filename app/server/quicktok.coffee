exports.actions =
  
  new: (cb) ->
    
    console.log 'Generating a new random url'
    hash = urlmapper((((1+Math.random())*0x10000)|0).toString(16)) 
	
    # Now we are creating a session
    SS.server.opentok.session (response) -> 
      R.set "hash:#{hash}", response
      params =
        hash: hash
      cb params

urlmapper =  (str) ->
  hash = SS.shared.hash.sha1(str)
  res = hash.substring(0,5)
  console.log "Hash #{str} calculates to #{res}"
  return res
