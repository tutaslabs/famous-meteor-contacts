
Contacts.allow
    insert: (userId, doc) ->
      return true
    update: (userId, doc, fields, modifier) ->
      return true
    remove: (userId, doc) ->
      return true

Meteor.publish 'contacts', ->
    Contacts.find({owner: {$in: ["public",this.userId]}})
