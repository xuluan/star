
###
Module dependencies.
###
mongoose = require("mongoose")
User = mongoose.model("User")
utils = require("../../lib/utils")
login = (req, res) ->
  if req.session.returnTo
    res.redirect req.session.returnTo
    delete req.session.returnTo

    return
  res.redirect "/"

exports.signin = (req, res) ->


###
Auth callback
###
exports.authCallback = login

###
Show login form
###
exports.login = (req, res) ->
  res.render "users/login",
    title: "Login"
    message: req.flash("error")



###
Show sign up form
###
exports.signup = (req, res) ->
  res.render "users/signup",
    title: "Sign up"
    user: new User()



###
Logout
###
exports.logout = (req, res) ->
  req.logout()
  res.redirect "/login"


###
Session
###
exports.session = login

###
Create user
###
exports.create = (req, res) ->
  user = new User(req.body)
  user.provider = "local"
  user.save (err) ->
    if err
      return res.render("users/signup",
        errors: utils.errors(err.errors)
        user: user
        title: "Sign up"
      )
    
    # manually login the user once successfully signed up
    req.logIn user, (err) ->
      return next(err)  if err
      res.redirect "/"




exports.update = (req, res) ->
  user =  req.current_user
  rc = user.change_password(req.body.password, req.body.new_password, req.body.new_password2 )
  if rc
    return res.render "users/show",
      errors: [rc]
      title: user.name
      user: user
  else
    user.save (err) ->
      if err
        return res.render "users/show",
          errors: utils.errors(err.errors)
          title: user.name
          user: user
      else
        return res.redirect "/"


###
Show current user
###
exports.show = (req, res) ->
  user = req.current_user
  res.render "users/show",
    title: user.name
    user: user


exports.loadUser = (req, res, next) ->
  id =  req.session.passport.user || null
  User.findOne(_id: id).exec (err, user) ->
    req.current_user = user unless err
    next()

###
Find user by id
###
exports.user = (req, res, next, id) ->
  User.findOne(_id: id).exec (err, user) ->
    return next(err)  if err
    return next(new Error("Failed to load User " + id))  unless user
    req.current_user = user
    next()
