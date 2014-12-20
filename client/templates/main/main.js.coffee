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
    $('.input-group').fadeOut(400, fadeItIn)


fadeItIn = ->
  $('.invitation-form').fadeIn()
