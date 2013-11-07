mongoose = require("mongoose")
LocalStrategy = require("passport-local").Strategy
TwitterStrategy = require("passport-twitter").Strategy
FacebookStrategy = require("passport-facebook").Strategy
GitHubStrategy = require("passport-github").Strategy
# GoogleStrategy = require("passport-google-oauth").Strategy
GoogleStrategy = require('passport-google-oauth').OAuth2Strategy
UserModel= require("../app/models/user")
User = mongoose.model("User")

module.exports = (passport, config) ->
  
  #Serialize sessions
  passport.serializeUser (user, done) ->
    done null, user.id

  passport.deserializeUser (id, done) ->
    User.findOne
      _id: id
    , (err, user) ->
      done err, user


  
  #Use local strategy
  passport.use new LocalStrategy(
    usernameField: "email"
    passwordField: "password"
  , (email, password, done) ->
    User.findOne
      email: email
    , (err, user) ->
      return done(err)  if err
      unless user
        return done(null, false,
          message: "Unknown user"
        )
      unless user.authenticate(password)
        return done(null, false,
          message: "Invalid password"
        )
      done null, user

  )

  
  # use google strategy
  passport.use new GoogleStrategy(
    clientID: config.google.clientID
    clientSecret: config.google.clientSecret
    callbackURL: config.google.callbackURL
  , (accessToken, refreshToken, profile, done) ->
    User.findOne
      "google.id": profile.id
    , (err, user) ->
      unless user
        user = new User(
          name: profile.displayName
          email: profile.emails[0].value
          username: profile.username
          provider: "google"
          google: profile._json
        )
        user.save (err) ->
          console.log err  if err
          done err, user

      else
        done err, user

  )
  
  # #Use google strategy
  # passport.use new GoogleStrategy(
  #   consumerKey: config.google.clientID
  #   consumerSecret: config.google.clientSecret
  #   callbackURL: config.google.callbackURL
  # , (accessToken, refreshToken, profile, done) ->
  #   User.findOne
  #     "google.id": profile.id
  #   , (err, user) ->
  #     unless user
  #       user = new User(
  #         name: profile.displayName
  #         email: profile.emails[0].value
  #         username: profile.username
  #         provider: "google"
  #         google: profile._json
  #       )
  #       user.save (err) ->
  #         console.log err  if err
  #         done err, user
  #
  #     else
  #       done err, user
  #
  # )
