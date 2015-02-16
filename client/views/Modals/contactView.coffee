Template.contactView.helpers
  'data': ->
    return Contacts.findOne Session.get('contactView')._id

  'email': ->
    return Session.get('contactView').emails
  'active': ->
    if this.details.active
      'Active'
    else
      'In-Active'


Template.contactView.events
  'click #b2':  (evt,tmpl) ->
    App.trans.set 90,{ duration: 1000, curve: Famous.Easing.easeIn },->
      cvs = FView.byId('cv').surface
      cvs.addClass 'hide'
      App.trans.set 0,{ duration: 0}
      App.events.emit 'displayHeadTabs'


  'click #b3':  (evt,tmpl) ->
      if App.click is off
        alert 'mail me'
        App.click = on
      Meteor.setTimeout ->
        App.click = off
      ,500

  'click #b4':  (evt,tmpl) ->
    if App.click is off
      alert 'call me'
      App.click = on
    Meteor.setTimeout ->
      App.click = off
    ,500


  'click #b5':  (evt,tmpl) ->
    if App.click is off
      App.click = on
      cvs = FView.byId('cv').surface
      App.trans.set 90,{ duration: 500, curve: Famous.Easing.easeIn },->
        cvs.addClass 'hide'
        App.trans.set 0,{ duration: 0}
        App.events.emit 'displayHeadTabs'
        Contacts.remove _id: Session.get('contactView')._id,
          (error,res) =>
            if error
              throw new Meteor.Error(404, error.sanitizedError)
    Meteor.setTimeout ->
      App.click = off
    ,500

  'click #b6':  (evt,tmpl) ->
    if App.click is off
      App.click = on
      cvs = FView.byId('cv').surface
      App.trans.set 90,{ duration: 500, curve: Famous.Easing.easeIn },->
        cvs.addClass 'hide'
        App.trans.set 0,{ duration: 0}
        Session.set 'currentHeadFootContentTemplate','updateContactForm'
        App.events.emit 'displayUpdate'
    Meteor.setTimeout ->
      App.click = off
    ,500