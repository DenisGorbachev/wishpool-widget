Template.index.helpers
  style: ->
    Styles.findOne()
  changed: ->
    Session.equals("changed", true)

Template.index.rendered = ->

Template.index.events
  'keydown input': (event, template) ->
    Session.set("changed", true)
  'keyup input': (event, template) ->
    feedback = template.$("input").val()
    defaultFeedback = Styles.findOne().label + " "
    Session.set("changed", feedback isnt defaultFeedback)
  'submit form': grab encapsulate (event, template) ->
    feedback = template.$("input").val()
    defaultFeedback = Styles.findOne().label + " "
    if feedback is defaultFeedback
      return # simple validation
    Feedbacks.insert({feedback: feedback})
    $('.input-group').fadeOut(400, ->
      $('.success').fadeIn()
    )
