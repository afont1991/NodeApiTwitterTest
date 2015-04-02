
mongoose = require('mongoose')

TopicSchema = new (mongoose.Schema)(
  events:
    type: String
    required: false
  name:
    type: String
    required: true
  isPromoted:
    type: Boolean
    required: false
  query:
    type: String
    required: false
  url:
    type: String
    required: false
)

exports.Topic = mongoose.model('Topic', TopicSchema)