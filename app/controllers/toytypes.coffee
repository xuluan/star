###
Module dependencies.
###
mongoose = require("mongoose")
Toytype = require("../models/toytype")
_ = require("underscore")
UPYun = require('../../lib/upyun').UPYun
fs = require('fs')

exports.loadToytype = (req, res) ->
  res.render "toytype"


testCallback = (err, data) ->
  unless err
    console.log "Data: "
    console.log data
  else
    console.log "Error: "
    console.log err

exports.toytype_upload = (req, res) ->
  console.log req.files
  console.log req.body["idx"]

  Toytype.findById(req.params.toytypeId).exec (err, toytype) ->
    if err
      console.err err
    else
      console.log "b "  + req.body["idx"]
      upyun = new UPYun("mystar", "test", "testtest")
      idx = req.body["idx"]
      console.log typeof(idx)
      console.log typeof(req.body["idx"])

      suffix = '_' + idx + '.png'
      console.log idx.toString()
      image_name = toytype.sno + suffix
      path = "/toytypes/"+image_name
      console.log path
      fs.readFile req.files.file.path, (err, data) ->
        upyun.writeFile(path, data, true, testCallback)

      toytype["image_" + idx] = path
      toytype.save (err) ->
        res.jsonp(toytype)

###
List of Toytypes
###
exports.list = (req, res) ->
  Toytype.find().sort("-created").exec (err, toytypes) ->
    if err
      console.err err
    else
      res.json toytypes

exports.create = (req, res) ->
  console.log "aaa"
  toytype = new Toytype req.body
  toytype.save()
  res.jsonp toytype

exports.update = (req, res) ->

  Toytype.findById(req.params.toytypeId).exec (err, toytype) ->
    if err
      console.err err
    else
      toytype = _.extend(toytype, req.body)

      toytype.save (err) ->
        res.jsonp(toytype)

exports.show = (req, res) ->
  Toytype.findById(req.params.toytypeId).exec (err, toytype) ->
    if err
      console.err err
    else
      res.jsonp toytype

exports.destroy = (req, res) ->
  Toytype.findById(req.params.toytypeId).exec (err, toytype) ->
    if err
      console.err err
    else
      toytype.remove (err) ->
        if err
          console.err err
        else
          res.jsonp toytype
