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
    feedback = template.$(".wishpool-input").val()
    defaultFeedback = Widgets.findOne().label + " "
    Session.set("changed", feedback isnt defaultFeedback)
  'submit form.widget-form': grab encapsulate (event, template) ->
    actualText = template.$(".wishpool-input").val()
    defaultText = Widgets.findOne().label + " "
    if actualText is defaultText
      return # simple validation
    parsedSourceUrl = URI.parse(location.toString())
    sourceParameters = URI.parseQuery(parsedSourceUrl.query)
    cl "sourceParameters.userEmail = '"+sourceParameters.userEmail+"'"
    if sourceParameters.userEmail isnt ""
      Feedbacks.insert(
        text: actualText
        parentUrl: Session.get("parentUrl")
        sourceUrl: location.toString()
      )
      $('.widget-group').fadeOut(400, ->
        $('.success').fadeIn()
      )
      Meteor.setTimeout(() ->
        $('.success').fadeOut(400, ->
          template.$(".wishpool-input").val(defaultText)
          $('.widget-group').fadeIn()
        )
      , 2000)
    else
      $('.input-group').fadeOut(400, ->
        $('.ask-email').fadeIn()
      )

  'submit form.email-form': grab encapsulate (event, template) ->
    actualText = template.$(".wishpool-input").val()
    defaultText = Widgets.findOne().label + " "
    email = template.$(".email-input").val()
    if email is "" or "@" not in email
      return

    Feedbacks.insert(
      text: actualText
      parentUrl: Session.get("parentUrl")
      sourceUrl: location.toString()
      email: email
    )
    $('.ask-email').fadeOut(400, ->
      $('.success').fadeIn()
    )
    Meteor.setTimeout(() ->
      $('.success').fadeOut(400, ->
        template.$(".wishpool-input").val(defaultText)
        $('.widget-group').fadeIn()
      )
    , 2000)

