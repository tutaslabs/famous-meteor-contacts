Template.contactScrollView.helpers
  'contacts': ->
    query = Contacts.find {owner: {$in: ["public",Meteor.userId()]}},{sort: {'name.last': 1}}