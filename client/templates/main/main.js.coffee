Template.main.helpers
  showButton: ->
    Session.get("showButton")

Template.main.rendered = ->
  Session.set("showButton", false)

Template.main.events
  'keyup input': grab encapsulate (event, template) ->
    Session.set("showButton", $(template.find("input")).val().length > 5)

  'submit form': grab encapsulate (event, template) ->
    if not Session.get("showButton")
      return # simple validation
    Feedbacks.insert({feedback: $(template.find("input")).val(), user: "anonymous"})
    $('.input-group').fadeOut(400, fadeItIn)


fadeItIn = ->
  $('.invitation-form').fadeIn()
