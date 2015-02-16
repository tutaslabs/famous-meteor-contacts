Template.header.rendered = ->

    labs = FView.byId('label').surface
    logins = FView.byId('login').surface
    logouts = FView.byId('logout').surface
    profiles = FView.byId('profile').surface
    users = FView.byId('user').surface
    loginForms = FView.byId('loginForm').surface


    App.events.on 'displayUpdate',->
      Session.set 'navIcon','<i class="fa fa-chevron-left"></i>'
      labs.setContent 'Update Contact'

    App.events.on 'hideHeadTabs',=>
      logins.addClass 'hide'
      logouts.addClass 'hide'
      profiles.addClass 'hide'
      users.addClass 'hide'

    App.events.on 'displayHeadTabs',=>
      if Meteor.user()
        logins.addClass 'hide'
        logouts.removeClass 'hide'
        profiles.removeClass 'hide'
        users.removeClass 'hide'
      else
        logins.removeClass 'hide'
        logouts.addClass 'hide'
        profiles.addClass 'hide'
        users.removeClass 'hide'

    logins.on 'click',->
      loginForms.removeClass 'hide'

    logouts.on 'click',->
      Meteor.logout()
      logins.removeClass 'hide'
      logouts.addClass 'hide'
      profiles.addClass 'hide'


    profiles.on 'click',->
      App.alert 'profile change'
    App.events.emit 'displayHeadTabs'

Template.header.helpers
  'user': ->
    if Meteor.user()
      return Meteor.user().username
    else
      return 'Guest'