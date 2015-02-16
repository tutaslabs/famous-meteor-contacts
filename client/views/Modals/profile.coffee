Template.profile.events
  'click #pcancel': (evt,tmp)->
    $('#perror').text('')
    s = FView.fromTemplate tmp
    s.surface.addClass 'hide'
    $('input[type="submit"],.profile').prop('disabled',false)

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
    return {
      name: Meteor.user().profile.name
      email: Meteor.user().profile.email
    }
  'dis': ->
    if Meteor.user().username is 'demo'
      return true
    else
      return false