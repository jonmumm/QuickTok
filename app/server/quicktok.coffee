exports.actions =
  
  new: (cb) ->
    
    console.log 'Generating a new random url'
    cb urlmapper((((1+Math.random())*0x10000)|0).toString(16)) 



urlmapper =  (str) ->
  hash = SS.shared.hash.sha1(str)
  res = hash.substring(0,5)
  console.log "Hash #{str} calculates to #{res}"
  return res
