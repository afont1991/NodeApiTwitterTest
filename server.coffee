'use strict'

bodyParser = require 'body-parser'
config = require('environmental-configuration')('./config')
express = require 'express'
hogan = require 'hogan-express'
mainController = require './controllers/main'


app = express()
app.use bodyParser.urlencoded
  extended: true
app.use bodyParser.json()
app.engine 'html', hogan
app.set 'view engine', 'html'
port = config.port or 10002

app.all '*', (req, res, next) ->
  res.header "Access-Control-Allow-Origin", "*"
  res.header 'Access-Control-Allow-Methods', 'GET,PUT,POST,HEAD,DELETE,OPTIONS'
  res.header "Access-Control-Allow-Headers", "Content-Type,X-Requested-With"
  res.header "Access-Control-Allow-Credentials", "true"
  next()

app.get "/birdie/rest/topics/:searchQuery", (req, res, next) ->
  mainController.getTopics req, res, next

app.post "/birdie/rest/topics", (req, res, next) ->
  mainController.addTopic req, res, next

app.post "/birdie/rest/topics/load", (req, res, next) ->
  mainController.reloadTopics req, res, next

app.delete "/birdie/rest/topics", (req, res, next) ->
  mainController.deleteTopic req, res, next

app.post "/do", (req, res, next) ->
  mainController.do req, res, next

app.get "/view/:id", (req, res, next) ->
  mainController.view req, res, next

# app.get "*", (req, res,  next) ->
#   res.json message: 'api working'
#   next()

app.listen port
console.log "ready on port: #{port}"