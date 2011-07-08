exports.actions =
  
  new: (cb) ->
    # Creates a new random hash of length 5 (note we can make this faster if needed)    
    hash = SS.shared.hash.create();
	
    params =
      url: "http://qtok.me/#{hash}"
      hash: hash

    cb params

  reserve: (hash, cb) ->
    # Now we are creating a session
    hashlen = hash.length
    
    if hashlen is 5
      SS.server.opentok.session (response) -> 
        R.set "hash:#{hash}", response
        params =
          url: "http://qtok.me/#{hash}"
          hash: hash
    else 
      params = 
          error : "Hash is not base64 of length 5"
    cb params
      
  get: (hash, cb) ->
    R.get "hash:#{hash}", (err, data) ->
      params = 
        sessionId: data
        token: SS.server.opentok.token()
        apiKey: SS.shared.constants.apiKey
      
      cb params

urlmapper =  (str) ->
  hash = SS.shared.hash.sha1(str)
  res = hash.substring(0,5)

  return res
