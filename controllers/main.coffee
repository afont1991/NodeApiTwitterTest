'use strict'

config = require('environmental-configuration')('./config')
queryString = require('query-string') #Simple package to parse the search query!
mongoose = require('mongoose')
Twitter = require('twitter') #Simple npm Module for making request to twitter
topicModel = require('../models/topicModel').Topic


mongoose.connect('mongodb://localhost/nodeServerTest');

#Setting up my twitter client to send request
twitterClient = new Twitter (
  consumer_key: ''
  consumer_secret: ''
  access_token_key: ''
  access_token_secret: ''
)

params = id: 1

twitterClient.get 'trends/place.json', params, (error, tweets, response) ->
  if !error
    console.log tweets
  return



exports.getTopics = (req, res, next) ->
  if req._parsedUrl.query
    console.log 'searching'
    query = req._parsedUrl.query
    parsedQuery = queryString.parse(query)
    console.log parsedQuery.query
    topicModel.find { name: new RegExp('^' + parsedQuery.query + '$', 'i') }, (err, topics) ->
      console.log err if err
      console.log topics
      res.json "it worked?"
  else
    topicModel.find query?, (err, topics) ->
      console.log err if err
      console.log topics
      res.json "it worked"

exports.addTopic = (req, res, next) ->
  newTopic = new topicModel

  newTopic.events = req.body.events if req.body.events
  newTopic.name = req.body.name if req.body.name
  newTopic.isPromoted = req.body.isPromoted if req.body.isPromoted
  newTopic.query = req.body.query if req.body.query
  newTopic.url = req.body.url if req.body.url

  newTopic.save (err, savedTopic) ->

    return res.json "Error occured: " + err if err

    res.json "Topic Saved"

exports.reloadTopics = (req, res, next) ->
  res.json "it worked"

exports.deleteTopic = (req, res, next) ->
  res.json "it worked"




