exports.actions =
  
  # This functions creates a unique hash that can be used to reserve a new chatroom.
  #
  # You can call this function to generate a short unique url and hash that 
  # can be used to reserve a quicktok video conversation.
  #
  # Calling this function will only generate the unique hash and the url where
  # you can find this chat. However it will not reserve the video conference yet.
  #
  # Example usage:
  #
  # curl http://qtok.me/api/quicktok/new
  #
  # Response:
  #
  #  {
  #    "url": "http://qtok.me/ETH9d",
  #    "hash":"ETH9d",
  #    "status": "OK"
  #  }
  new: (cb) ->
    # Creates a new random hash of length 5 (note we can make this faster if needed)    
    hash = SS.shared.hash.create();
	
    params =
      url: "http://qtok.me/#{hash}"
      hash: hash
      status: "OK"

    cb params

  # This function reserves a video chat room for the given hash.
  #
  # You can can call this function with a hash to actually reserve your video chat. 
  # The hash passed in should be obtained by calling the new function.  
  #
  # Errors will be returned in the status field of the return json object. Anything
  # besides "OK" indicates an error.
  #
  # Common errors:
  #   * "ERROR: Hash is not a pseudo base64 of length 5"
  #      You didn't pass in a hash that was obtained by calling the new function.
  #      This is a fatal error, this url will never work.
  #   *  "WARNING: Video session already reserved"
  #      Somebody (possibly you) already called reserve with the given hash.
  #      The video chat has already been reserved. (This is not a fatal error)
  #
  # Example usage:
  #
  # curl http://qtok.me/api/quicktok/reserve?ETH9d
  #
  # Response:
  #
  #
  #  {
  #    "url": "http://qtok.me/ETH9d",
  #    "hash":"ETH9d",
  #    "status": "OK"
  #  }
  #
  # Error sample:
  #
  # curl http://qtok.me/api/quicktok/reserve?ETH9d
  #
  # Response:
  #
  #
  #  {
  #    "url": "http://qtok.me/ETH9d",
  #    "hash":"ETH9d",
  #    "status": "WARNING: Video session already reserved"
  #  }
  #
  reserve: (hash, cb) ->
    # Now we are creating a session    

    if hash.length isnt 5
      params = 
        status: "ERROR: Hash is not a pseudo base64 of length 5"
      cb params
      return

    R.exists "hash:#{hash}", (err, data) ->
      if data is 1
        params =
          url: "http://qtok.me/#{hash}"
          hash: hash
          status: "WARNING: Video session already reserved"
        cb params
      else
        SS.server.opentok.session (response) ->
          R.set "hash:#{hash}", response
          params =
            url: "http://qtok.me/#{hash}"
            hash: hash
            status: "OK"
          cb params
    
      
  get: (hash, cb) ->
    R.get "hash:#{hash}", (err, data) ->
      params = 
        sessionId: data
        token: SS.server.opentok.token()
        apiKey: SS.shared.constants.apiKey
      
      cb params


