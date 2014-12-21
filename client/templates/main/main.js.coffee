Template.main.helpers
  showButton: ->
    Session.get("showButton")

Template.main.rendered = ->
  Session.set("showButton", false)

Template.main.events
  'keyup input': grab encapsulate (event, template) ->
    Session.set("showButton", $(template.find("input")).val().length > 5)
    if event.keyCode is 13
      $('button').click()

  'click button': grab encapsulate (event, template) ->
    share.Feedbacks.insert({feedback: $(template.find("input")).val(), user: "anonymous"})
    $('.input-group').fadeOut(400, fadeItIn)
    cl(document.referrer)


fadeItIn = ->
  $('.invitation-form').fadeIn()
