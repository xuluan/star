###
Module dependencies.
###
mongoose = require("mongoose")
env = process.env.NODE_ENV or "development"
config = require("../../config/config")[env]
Schema = mongoose.Schema

###
Article Schema
###
ArticleSchema = new Schema
  created:
    type: Date
    default: Date.now

  title:
    type: String
    default: ""
    trim: true

  content:
    type: String
    default: ""
    trim: true
  
  link:
    type: String
    default: ""
    trim:true
    
  

  # user:
  #   type: Schema.ObjectId
  #   ref: "User"

###
Statics
###
# ArticleSchema.statics = load: (id, cb) ->
#   @findOne(_id: id).populate("user").exec cb

module.exports = mongoose.model "Article", ArticleSchema