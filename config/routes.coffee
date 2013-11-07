async = require('async')

module.exports = (server, config, passport, auth) ->
  users = require('../app/controllers/users')
  # server.get "/signup", users.signup

  server.get "/login", users.login
  server.get "/logout", users.logout
  server.post "/users", users.create
  server.post "/users/update/:userId", users.update
  server.post "/users/session", passport.authenticate("local",
    failureRedirect: "/login"
    failureFlash: "Invalid email or password."
  ), users.session
  server.get "/users/:userId", users.show
  
  server.param('userId', users.user)
 
  server.get "/", (req, res) ->
    res.render "index"
    
  articles = require('../app/controllers/articles')
  server.get('/articles', articles.list)
  server.post('/articles', articles.create)
  server.get('/articles/:articleId', articles.show)
  server.put('/articles/:articleId', articles.update)
  server.del('/articles/:articleId', articles.destroy)