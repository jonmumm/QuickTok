exports.actions = 
  
  new: (id, cb) ->
    
    console.log 'Hello world'
    
    chat = 
      id: id
      name: "My name"
      
    R.set "chat:#{id}", JSON.stringify(chat)
    
    R.get "chat:#{id}", (err, data) =>
      chat = JSON.parse(data)
      console.log chat
      
    SS.publish.broadcast 'newChat', chat  
      
    cb chat