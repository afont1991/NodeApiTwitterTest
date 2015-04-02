'use strict'

config = require('environmental-configuration')('./config')


exports.getTopics = (req, res, next) ->
  res.json "it worked"

exports.addTopic = (req, res, next) ->
  res.json "it worked"

exports.reloadTopics = (req, res, next) ->
  res.json "it worked"

exports.deleteTopic = (req, res, next) ->
  res.json "it worked"




