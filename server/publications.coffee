Meteor.publish("feedbacks", ->
  share.Feedbacks.find()
)