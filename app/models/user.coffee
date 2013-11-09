###
Module dependencies.
###
mongoose = require("mongoose")
Schema = mongoose.Schema
crypto = require("crypto")
_ = require("underscore")
authTypes = ["github", "twitter", "facebook", "google", "linkedin"]

###
User Schema
###
UserSchema = new Schema(
  email:
    type: String
    default: ""
    unique: true

  username:
    type: String
    default: ""

  role:
    type: String
    default: "customer"
    enum: ["admin", "leader", "assistant", "customer", "ban"]


  provider:
    type: String
    default: ""

  hashed_password:
    type: String
    default: ""

  salt:
    type: String
    default: ""

  authToken:
    type: String
    default: ""

  facebook: {}
  twitter: {}
  github: {}
  google: {}
  linkedin: {}
)

###
Virtuals
###
UserSchema.virtual("password").set((password) ->
  @_password = password
  @salt = @makeSalt()
  @hashed_password = @encryptPassword(password)
).get ->
  @_password

UserSchema.virtual("password2").set((password) ->
  @_password2 = password
).get ->
  @_password2

UserSchema.virtual("password_change").set((password_change) ->
  @_password_change = password_change
).get ->
  @_password_change

###
Validations
###
validatePresenceOf = (value) ->
  value and (value.length in [4..10])


UserSchema.path("email").index {unique:true}

UserSchema.path("email").validate ((email) ->
  
  # if you are authenticating by any of the oauth strategies, don't validate
  return true  if authTypes.indexOf(@provider) isnt -1
  mailPattern = /.+\@.+\..+/
  email.match mailPattern
), "Email isn't a valid email"


UserSchema.path("email").validate ((email, fn) ->
  User = mongoose.model("User")
  
  # if you are authenticating by any of the oauth strategies, don't validate
  # fn true  if authTypes.indexOf(@provider) isnt -1
  
  # Check only when it is a new user or when email field is modified
  if @isNew or @isModified("email")
    User.find(email: email).exec (err, users) ->
      fn not err and users.length is 0
  else
    fn true
), "Email already exists"
UserSchema.path("username").validate ((username) ->
  
  # if you are authenticating by any of the oauth strategies, don't validate
  return true  if authTypes.indexOf(@provider) isnt -1
  validatePresenceOf username
), "Username length must be between 4 to 20"
UserSchema.path("hashed_password").validate ((hashed_password) ->
  
  # if you are authenticating by any of the oauth strategies, don't validate
  return true  if authTypes.indexOf(@provider) isnt -1
  if @isNew or @_password_change
    validatePresenceOf(@_password)
  else
    hashed_password.length
), "Password length must be between 4 to 20"
UserSchema.path("hashed_password").validate ((hashed_password) ->
  
  # if you are authenticating by any of the oauth strategies, don't validate
  return true  if authTypes.indexOf(@provider) isnt -1
  if @isNew or @_password_change
    @_password == @_password2
  else
    hashed_password.length
), "Password must be equal with Confirm Password"


###
Pre-save hook
###
UserSchema.pre "save", (next) ->
  return next()  unless @isNew
  if not validatePresenceOf(@password) and authTypes.indexOf(@provider) is -1
    next new Error("Invalid password")
  else
    next()


###
Methods
###
UserSchema.methods =
  
  ###
  Authenticate - check if the passwords are the same
  
  @param {String} plainText
  @return {Boolean}
  @api public
  ###
  authenticate: (plainText) ->
    @encryptPassword(plainText) is @hashed_password

  
  ###
  Make salt
  
  @return {String}
  @api public
  ###
  makeSalt: ->
    Math.round((new Date().valueOf() * Math.random())) + ""

  
  ###
  Encrypt password
  
  @param {String} password
  @return {String}
  @api public
  ###
  encryptPassword: (password) ->
    return ""  unless password
    encrypred = undefined
    try
      encrypred = crypto.createHmac("sha1", @salt).update(password).digest("hex")
      return encrypred
    catch err
      return ""

  change_password: (password, newpassword, newpassword2) ->
    return "old password error" unless @authenticate(password)
    console.log @
    @set('password', newpassword)
    @set('password2', newpassword2)
    @set('password_change', true)


    console.log "self2 " +@

    return null

      
User = mongoose.model "User", UserSchema

###
user = new User
  username: 'admin'
  password: 'admin'
  password2: 'admin'
  email: 'rolle.xu@gmail.com'
  role: 'admin'
user.save (err) ->
  if err
    console.log err
  else
    console.log 'Created user: ' + user.username

###
