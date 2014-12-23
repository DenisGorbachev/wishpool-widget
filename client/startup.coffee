Meteor.startup ->
  url = (if window.location != window.parent.location then document.referrer else document.location).toString()
  Meteor.call("ping", url)