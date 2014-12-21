Meteor.methods(
  "ping": (url) ->
    check(url, String)
    @unblock()
    ping = share.Pings.findOne({url: url})
    if not ping
      share.Pings.insert({url: url})
    true
)