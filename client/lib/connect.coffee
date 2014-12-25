@MasterConnection = DDP.connect(Meteor.settings.public.masterUrl)

@Widgets = new Meteor.Collection("widgets", MasterConnection)
@Feedbacks = new Meteor.Collection("feedbacks", MasterConnection)

widgetId = ""
splinters = location.pathname.split("/")
for splinter in splinters # IE doesn't include forward slash in pathname, while other browsers do
  if splinter
    widgetId = splinter

MasterConnection.subscribe("widgetById", widgetId)

if not Session.get("parentUrl") # document.referrer changes after hot code reload; preserve original in Session
  Session.set("parentUrl", (if window.location != window.parent.location then document.referrer else document.location).toString())
if not Meteor.settings.public.isDebug
  MasterConnection.call("ping", Session.get("parentUrl"))