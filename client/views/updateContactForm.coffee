Template.updateContactForm.helpers
  'record': ->
    id  = Session.get('contactView')._id
    Contacts.findOne id