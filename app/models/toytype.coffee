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

  sno:
    type: String
    default: ""
    trim: true
    unique: true


  cname:
    type: String
    default: ""
    trim: true
  
  ename:
    type: String
    default: ""
    trim:true
    
  age:
    type: String
    default: ""
    trim: true
  
  price:
    type: Number
    default: "0"

  office_price:
    type: Number
    default: "0"

  buying_price:
    type: Number
    default: "0"       

  release_year:
    type: Number
    default: "0" 

  pieces:
    type: Number
    default: "0"

  doll_num:
    type: Number
    default: "0"

  volume:
    type: Number
    default: "0"       

  weight:
    type: Number
    default: "0"     


  mode:
    type: String
    default: "小颗粒"
    enum: ["小颗粒", "大颗粒", "未知"]

  desc:
    type: String
    default: ""
    trim:true

  image_main:
    type: String
    default: ""

  image_1:
    type: String
    default: ""

  image_2:
    type: String
    default: ""    

ToytypeSchema.path("sno").index {unique:true}


module.exports = mongoose.model "Toytype", ToytypeSchema