###
Module dependencies.
###
mongoose = require("mongoose")
Toytype = require("../models/toytype")
_ = require("underscore")


exports.loadToytype = (req, res) ->
  res.render "toytype"


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
  console.log  req.params.toytypeId

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
