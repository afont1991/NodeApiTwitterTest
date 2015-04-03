'use strict'

config = require('environmental-configuration')('./config')
queryString = require('query-string') #Simple package to parse the search query!
mongoose = require('mongoose')
Twitter = require('twitter') #Simple npm Module for making request to twitter
topicModel = require('../models/topicModel').Topic


mongoose.connect(config.mongoURL);

#Setting up my twitter client to send request
#Due to issues with creating my account i have the credentials empty
twitterClient = new Twitter (
  consumer_key: ''
  consumer_secret: ''
  access_token_key: ''
  access_token_secret: ''
)


# Right now this is limited to only searching by name..
exports.getTopics = (req, res, next) ->
  if req._parsedUrl.query
    query = req._parsedUrl.query
    parsedQuery = queryString.parse(query)
    topicModel.find { name: new RegExp('^'+parsedQuery.query, 'i') }, (err, topics) ->
      return res.json "Error occured: " + err if err
      res.json topics
  else
    topicModel.find query?, (err, topics) ->
      return res.json "Error occured: " + err if err
      res.json topics

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
  # Remove exisiting topics before loading new ones
  topicModel.remove (err, topics) ->
    params = id: 1
    twitterClient.get 'trends/place.json', params, (error, tweets, response) ->

      if error
        console.log '~|Loading fake data in place of twitter!|~'
        trendingTopics = config.fakeTwitterData[0].trends #the fake config data is identical to the twitter api response
      else
        trendingTopics = response[0].trends

      for topic in trendingTopics

        newTopic = new topicModel
        newTopic.events = topic.events
        newTopic.name = topic.name
        newTopic.isPromoted = topic.promoted_content
        newTopic.query = topic.query
        newTopic.url = topic.url

        newTopic.save (err, savedTopic) ->
          return err if err

      res.json "Data Reloaded"

exports.deleteTopic = (req, res, next) ->
  if req.body.query
    topicModel.find({ name: new RegExp('^'+req.body.query, 'i') }).remove (err) ->
      return res.json "Error occured: " + err if err
      console.log topics
      res.json "Topics matching query removed"
  else
    console.log "No query passed deleting all topics!"
    topicModel.remove (err, topics) ->
      return res.json "Error occured: " + err if err
      topics.remove
      res.json "Topics removed"




