@MasterConnection = DDP.connect(Meteor.settings.public.masterUrl)

@Widgets = new Meteor.Collection("widgets", MasterConnection)
@Feedbacks = new Meteor.Collection("feedbacks", MasterConnection)
@TokenEmails = new Meteor.Collection("token_emails", MasterConnection)

splinters = location.pathname.split("/")
splinters = _.compact(splinters) # IE doesn't include forward slash in pathname, while other browsers do
widgetId = splinters[0]

share.widgetSubscription = MasterConnection.subscribe("widgetById", widgetId)

if not Session.get("parentUrl") # document.referrer changes after hot code reload; preserve original in Session
  Session.set("parentUrl", (if window.location != window.parent.location then document.referrer else document.location).toString())
MasterConnection.call("ping", Session.get("parentUrl"), widgetId)

share.wishpoolOwnerToken = if Meteor.settings.public.isDebug then "token_J7H9PNSNPQL5jymRx" else store.get("wishpoolOwnerToken")
if not share.wishpoolOwnerToken
  share.wishpoolOwnerToken = "token_" + Random.id()
  store.set("wishpoolOwnerToken", share.wishpoolOwnerToken)
share.tokenEmailSubscription = MasterConnection.subscribe("TokenEmails", share.wishpoolOwnerToken)


