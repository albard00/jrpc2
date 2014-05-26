module.exports = (server) ->
  (req, res, next) ->
    if req.method is 'POST'
      data = ''
      req.on 'data', (chunk)->
        data += chunk
      req.on 'end', ->
        server.handleRequest data, req.headers, (answer) ->
          if answer
            res.writeHead 200, {'Content-Type': 'application/json'}
            res.write JSON.stringify answer
          res.end()
    else
      next()