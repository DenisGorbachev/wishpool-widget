Meteor.startup ->
  if not Meteor.settings.public.isDebug
    url = (if window.location != window.parent.location then document.referrer else document.location).toString()
    Meteor.call("ping", url)