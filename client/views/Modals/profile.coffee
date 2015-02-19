Template.profile.events
  'click #pcancel': (evt,tmp)->
    $('#perror').text('')
    s = FView.fromTemplate tmp
    s.surface.addClass 'hide'
    $('input[type="submit"],.profile').prop('disabled',false)
    AutoForm.resetForm 'profile'
    if iOS
      sv = FView.byId 'csv'
      sv.view.goToPage 0
  'click #delete': (evt,tmp)->
      if Meteor.user().username isnt 'admin'
        Meteor.logout()
        Meteor.call 'deleteAccount',Session.get 'user'
        Session.set 'user',''
        $('#perror').text('')
        s = FView.fromTemplate tmp
        s.surface.addClass 'hide'
        $('input[type="submit"],.profile').prop('disabled',false)
        if iOS
          sv = FView.byId 'csv'
          sv.view.goToPage 0
        App.events.emit 'displayHeadTabs'
  'click #password': (evt,tmp)->
      if Meteor.user().username is 'demo'
        $('#perror').text('Can not chg demo password')
      else
        $('#perror').text('')
        s = FView.fromTemplate tmp
        s.surface.addClass 'hide'
        pf = FView.byId 'passwordForm'
        pf.surface.removeClass 'hide'


Template.profile.helpers
  'data': ->
    c = Session.get('user')
    if Meteor.user()
      return {
        name:  Meteor.user().profile.name
#      email: Meteor.user().profile.email
        email: Meteor.user().emails[0].address
      }
    else
      return {
        name: ' '
        email: ' '
      }
  'dis': ->
    if Meteor.user() and Meteor.user().username is 'demo'
      return true
    else
      return false