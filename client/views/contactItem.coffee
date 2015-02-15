Template.contactItem.events
  'click #b1':  (evt,tmpl) ->
    # meteor goodness here - the data passed to the template for rendering is passed to us in 'this'
    # so we have access to the unique chat ID value of the entry
    t = this._id
    Session.set 'contactView',this
    App.events.emit 'hideHeadTabs'
    cvs = FView.byId('cv').surface
    cvs.removeClass 'hide'

Template.contactItem.helpers
  'public': ->
    if this.owner is 'public'
      'public'
    else
      'mine'
  'active': ->
      if this.details.active
        'active'
      else
        'inactive'