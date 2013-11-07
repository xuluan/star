###
Module dependencies.
###
mongoose = require("mongoose")
Article = require("../models/article")
_ = require("underscore")



###
List of Articles
###
exports.list = (req, res) ->
  Article.find().sort("-created").exec (err, articles) ->
    if err
      console.err err
    else
      res.json articles

exports.create = (req, res) ->
  article = new Article req.body
  article.save()
  res.jsonp article

exports.update = (req, res) ->
  Article.findById(req.params.articleId).exec (err, article) ->
    if err
      console.err err
    else
      article = _.extend(article, req.body)
      article.save (err) ->
        res.jsonp(article)

exports.show = (req, res) ->
  Article.findById(req.params.articleId).exec (err, article) ->
    if err
      console.err err
    else
      res.jsonp article

exports.destroy = (req, res) ->
  Article.findById(req.params.articleId).exec (err, article) ->
    if err
      console.err err
    else
      article.remove (err) ->
        if err
          console.err err
        else
          res.jsonp article
