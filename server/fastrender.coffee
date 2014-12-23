FastRender.route("/:_id", (params) ->
  @subscribe("style", params._id)
)