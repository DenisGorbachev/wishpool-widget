Template.index.helpers
  widget: ->
    Widgets.findOne()
  currentUserTokenEmail: ->
    TokenEmails.findOne({wishpoolOwnerToken: share.wishpoolOwnerToken})
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
    if actualText is defaultText or actualText is ""
      return # simple validation

#    trying to find out if user left his email
    parsedSourceUrl = URI.parse(location.toString())
    sourceParameters = URI.parseQuery(parsedSourceUrl.query)
    tokenEmail = TokenEmails.findOne({wishpoolOwnerToken: share.wishpoolOwnerToken})?.email

    if sourceParameters.userEmail isnt "" or tokenEmail
      Feedbacks.insert(
        text: actualText
        parentUrl: Session.get("parentUrl")
        sourceUrl: location.toString()
        email: sourceParameters.userEmail or tokenEmail
      )
      $('.widget-group').fadeOut(400, ->
        $('.success').fadeIn()
      )
      Meteor.setTimeout(() ->
        $('.success').fadeOut(400, ->
          template.$(".wishpool-input").val(defaultText)
          $('.widget-group').fadeIn()
          Session.set("changed", false)
        )
      , 2000)
    else
      feedbackId = Feedbacks.insert(
        text: actualText
        parentUrl: Session.get("parentUrl")
        sourceUrl: location.toString()
        sourceUserToken: share.wishpoolOwnerToken
      )
      $('.input-group').fadeOut(400, ->
        $('.ask-email').focus()
        $('.ask-email').fadeIn()
      )

  'submit form.email-form': grab encapsulate (event, template) ->
    actualText = template.$(".wishpool-input").val()
    defaultText = Widgets.findOne().label + " "
    email = template.$(".email-input").val()
    if not email.match(share.emailLinkRegExp)
      return
    TokenEmails.insert(
      email: email
      wishpoolOwnerToken: share.wishpoolOwnerToken
    )
    $('.ask-email').fadeOut(400, ->
      $('.success').fadeIn()
    )
    Meteor.setTimeout(() ->
      $('.success').fadeOut(400, ->
        template.$(".wishpool-input").val(defaultText)
        $('.widget-group').fadeIn()
        Session.set("changed", false)
      )
    , 2000)

