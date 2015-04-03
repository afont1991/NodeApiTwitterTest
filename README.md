

# Node API and Server

My basic Node Server for use In projects

## Running

- npm install
- Run 'mongod' (make sure you have mongoDB installed!)
- Run 'coffee index.coffee' (You made need to install coffee script "npm install -g coffee-script")

## Using the API

 - Loading Topics: POST to http://localhost:10002/birdie/rest/topics/load (This will load in new data if its your first time running it)

 - Geting topics: GET to http://localhost:10002/birdie/rest/topics?query=someRandomString (The query at the end of the URL is optional. If not passed you will get back an array of ALL topics!)
  > Keep in mind the search currently only looks at topic names!

 - Creating New Topics: POST to http://localhost:10002/birdie/rest/topics
  > Pass an object with the information you'd like to save about the topic like so:
    {
      "events": null,
      "name": "Sweet Dreams",
      "isPromoted": null,
      "query": "%22Sweet%20Dreams%22",
      "url": "http://twitter.com/search/?q=%22Sweet%20Dreams%22"
    }
  > Every field except the name field is optional...

- Deleting Topics: DELETE to http://localhost:10002/birdie/rest/topics
  > You can pass a query in the body that looks like {"query": "randomWordsAreCool"} which will be used to search the DB
  
  > If no query is sent then all topics will be removed from the DB