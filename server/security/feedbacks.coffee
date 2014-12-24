Feedbacks.allow
  insert: share.securityRulesWrapper (userId, feedback) ->
    check(feedback,
      _id: Match.App.Id
      title: String
      slug: Match.App.getEntrySlugUniqueMatch(feedback._id, feedback.wikiId)
      html: String
      tags: [String]
      wikiId: Match.App.WikiId
      isPublic: Boolean
      ownerId: Match.App.UserId
      updatedAt: Date
      createdAt: Date
    )
    true
