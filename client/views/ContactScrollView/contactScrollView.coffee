Template.contactScrollView.helpers
  'contacts': ->
    query = Contacts.find {},{sort: {'name.last': 1}}