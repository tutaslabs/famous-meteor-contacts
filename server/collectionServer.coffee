
Contacts.allow
    insert: (userId, doc) ->
      return false
    update: (userId, doc, fields, modifier) ->
      return true
    remove: (userId, doc) ->
      return false

Meteor.publish 'contacts', ->
    Contacts.find()
