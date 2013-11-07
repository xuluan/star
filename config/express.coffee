
express = require 'express'
flash = require 'connect-flash'
fs = require 'fs'
assets  = require 'connect-assets'
path  = require 'path'
helpers = require 'view-helpers'

module.exports = (server, config, passport) ->
  views_path  = config.root + '/app/views'

  server.use express.favicon()
  
  server.set "views", views_path
  # server.set "view engine", "ejs"
  server.set 'view engine', 'jade'
  
  server.enable "jsonp callback"
  
  server.configure "development", ->
    server.use express.logger('dev')

  server.configure "production", ->
    server.use express.logger()
    server.use express.compress()
    
  server.use express.bodyParser()
  server.use express.methodOverride()
  server.use assets()
  server.use express.cookieParser(config.cookieSecret)
  server.use express.session
    secret: config.secret
    maxAge: 3600000
    
  server.use flash()
    
  server.use helpers(config.app.name)
  
  server.use passport.initialize()
  server.use passport.session()
  
  server.use server.router
  server.use express.static(path.join(config.root, "public"))
  
  # server.use (req, res, next) ->
  #   res.status(404).render('404', {})
  
  server.use (err, req, res, next) ->
    #Log it
    console.error err.stack

    #Error page
    res.send 500, 'Something broken!<br/><pre>' + err.stack + '</pre>'


    