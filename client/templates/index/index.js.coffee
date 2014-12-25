Template.index.helpers
  widget: ->
    Widgets.findOne()
  changed: ->
    Session.equals("changed", true)

Template.index.rendered = ->

Template.index.events
  'keydown input': (event, template) ->
    Session.set("changed", true)
  'keyup input': (event, template) ->
    feedback = template.$("input").val()
    defaultFeedback = Widgets.findOne().label + " "
    Session.set("changed", feedback isnt defaultFeedback)
  'submit form': grab encapsulate (event, template) ->
    actualText = template.$("input").val()
    defaultText = Widgets.findOne().label + " "
    if actualText is defaultText
      return # simple validation
    Feedbacks.insert(
      text: actualText
      parentUrl: Session.get("parentUrl")
      sourceUrl: location.toString()
    )
    $('.input-group').fadeOut(400, ->
      $('.success').fadeIn()
    )
