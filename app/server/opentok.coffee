opentok = require 'opentok'
ot = new opentok.OpenTokSDK(SS.shared.constants.apiKey, '3272571db984f6c32e9bf3e457f14f70d84c531d')

exports.actions = 

  session: (cb) ->
    ot.createSession 'localhost', {}, (session) ->
      cb session.sessionId
      
  token: () ->
    return ot.generateToken()
