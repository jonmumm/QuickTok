opentok = require 'opentok'
ot = new opentok.OpenTokSDK('1566461', '3272571db984f6c32e9bf3e457f14f70d84c531d')

exports.actions = 

  session: (cb) ->
    ot.createSession 'localhost', {}, (session) ->
      cb session.sessionId
      
  token: (cb) ->
    cb ot.generateToken()
