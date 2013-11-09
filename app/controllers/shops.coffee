###
Module dependencies.
###
mongoose = require("mongoose")
Shop = require("../models/shop")
_ = require("underscore")


exports.loadShop = (req, res) ->
  res.render "shop"


###
List of Shops
###
exports.list = (req, res) ->
  Shop.find().sort("-created").exec (err, shops) ->
    if err
      console.err err
    else
      res.json shops

exports.create = (req, res) ->
  shop = new Shop req.body
  shop.save()
  res.jsonp shop

exports.update = (req, res) ->
  console.log  req.params.shopId

  Shop.findById(req.params.shopId).exec (err, shop) ->
    if err
      console.err err
    else
      console.dir req.body
      console.log "update " + _.extend(shop, req.body)

      shop = _.extend(shop, req.body)

      shop.save (err) ->
        res.jsonp(shop)

exports.show = (req, res) ->
  Shop.findById(req.params.shopId).exec (err, shop) ->
    if err
      console.err err
    else
      res.jsonp shop

exports.destroy = (req, res) ->
  Shop.findById(req.params.shopId).exec (err, shop) ->
    if err
      console.err err
    else
      shop.remove (err) ->
        if err
          console.err err
        else
          res.jsonp shop
