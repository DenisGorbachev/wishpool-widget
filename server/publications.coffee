Meteor.publish("style", (_id) ->
  Styles.find(_id, {fields: {accessibleBy: 0}})
)
