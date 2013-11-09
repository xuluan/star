###
Module dependencies.
###
mongoose = require("mongoose")
env = process.env.NODE_ENV or "development"
config = require("../../config/config")[env]
Schema = mongoose.Schema

###
Toytype Schema
###
ToytypeSchema = new Schema
  created:
    type: Date
    default: Date.now

  title:
    type: String
    default: ""
    trim: true

  addr:
    type: String
    default: ""
    trim: true
  
  tel:
    type: String
    default: ""
    trim:true
    
  status:
    type: String
    default: "正常"
    enum: ["正常", "暂停", "关闭"]

  desc:
    type: String
    default: ""
    trim:true




module.exports = mongoose.model "Toytype", ToytypeSchema