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
    Session.set("changed", $(event.currentTarget).val() isnt Styles.findOne().label + " ")
  'submit form': grab encapsulate (event, template) ->
    if not Session.get("showButton")
      return # simple validation
    Feedbacks.insert({feedback: $(template.find("input")).val(), user: "anonymous"})
    $('.input-group').fadeOut(400, fadeItIn)


fadeItIn = ->
  $('.invitation-form').fadeIn()
