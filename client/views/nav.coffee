Template.nav.events
  'click':  (evt,tmpl) ->

    labs = FView.byId('label').surface
    if App.click is false
      App.click = true

      if Session.get('currentHeadFootContentTemplate') is 'contactScrollView'
          Session.set 'currentHeadFootContentTemplate','insertContactForm'
          Session.set 'navIcon', '<i class="fa fa-chevron-left"></i>'
          labs.setContent 'New Contact'
      else if Session.get('currentHeadFootContentTemplate') is 'insertContactForm'
          Session.set 'currentHeadFootContentTemplate','contactScrollView'
          Session.set 'navIcon', '<i class="fa fa-plus"></i>'
          labs.setContent 'Contacts'
      else if Session.get('currentHeadFootContentTemplate') is 'updateContactForm'
          Session.set 'currentHeadFootContentTemplate','contactScrollView'
          Session.set 'navIcon', '<i class="fa fa-plus"></i>'
          labs.setContent 'Contacts'
    Meteor.setTimeout ->
      App.click = false
    ,500

Template.nav.helpers
  'icon': ->
    Session.get 'navIcon'
