Template.header.rendered = ->

    labs = FView.byId('label').surface
    logins = FView.byId('login').surface
    logouts = FView.byId('logout').surface
    profiles = FView.byId('profile').surface
    users = FView.byId('user').surface
    loginForms = FView.byId('loginForm').surface
    profileForms = FView.byId('profileForm').surface
    offline = FView.byId('offline').surface


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
      if iOS
        sv = FView.byId 'csv'
        sv.view.goToPage 10
      loginForms.removeClass 'hide'

    logouts.on 'click',->
      Meteor.logout()
      Session.set 'user',''
      logins.removeClass 'hide'
      logouts.addClass 'hide'
      profiles.addClass 'hide'


    profiles.on 'click',->
      if iOS
        sv = FView.byId 'csv'
        sv.view.goToPage 10


      profileForms.removeClass 'hide'


    App.events.emit 'displayHeadTabs'

Template.header.helpers
  'user': ->
    if Meteor.user()
      Session.set 'user',Meteor.userId()
      logins = FView.byId('login').surface
      logouts = FView.byId('logout').surface
      profiles = FView.byId('profile').surface
      users = FView.byId('user').surface

      logins.addClass 'hide'
      logouts.removeClass 'hide'
      profiles.removeClass 'hide'
      users.removeClass 'hide'
      return Meteor.user().username
    else
      logins = FView.byId('login').surface
      logouts = FView.byId('logout').surface
      profiles = FView.byId('profile').surface
      users = FView.byId('user').surface

      logins.removeClass 'hide'
      logouts.addClass 'hide'
      profiles.addClass 'hide'
      users.removeClass 'hide'
      return 'Guest'
  'status': ->

    if Meteor.status().connected
      offline = FView.byId('offline').surface
      offline.removeClass 'offline'
      return 'Online'
    else
      offline = FView.byId('offline').surface
      offline.addClass 'offline'
      return 'Offline'