###
  Requires
###
env = process.env.NODE_ENV || 'development'

express = require 'express'
fs = require('fs')
passport = require('passport')
assets  = require 'connect-assets'
path  = require 'path'
http  = require 'http'
coffee  = require 'coffee-script'
auth = require('./config/middlewares/authorization')
config = require('./config/config')[env]
mongoose = require 'mongoose'
db = mongoose.connect config.db

# models_path = config.root + '/app/models'
# fs.readdirSync(models_path).forEach (file) ->
#   require models_path + '/' + file
    
require('./config/passport')(passport, config)

server  = express()

require('./config/express')(server, config, passport)

require('./config/routes')(server, config, passport, auth)

port = process.env.PORT || config['port']
http.createServer(server).listen port , ->
  console.log 'Express server listening on port ' + port
  
module.exports = server