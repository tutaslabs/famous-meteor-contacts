#declare namespaces
window.App ?= {}
window.Famous ?={}


Meteor.startup  ->
  Logger.setLevel 'famous-views','debug'
  Meteor.subscribe 'contacts'
  App.transitionContent =  'slideWindow'
  Session.set 'currentHeadFootContentTemplate','contactScrollView'
  App.click = false
  App.events = new Famous.EventHandler
  Session.set 'navIcon','<i class="fa fa-plus"></i>'
  Session.set 'alert','none'
  Session.set 'user',''


AutoForm.hooks
  login:
    onSubmit: (doc) ->
        Meteor.loginWithPassword doc.username,doc.password,(err) =>
          if ! err
            Session.set 'user',Meteor.userId()
            this.done()
            $('#lerror').text ''
            App.events.emit 'displayHeadTabs'
            sv = FView.byId 'loginForm'
            sv.surface.addClass 'hide'
            if iOS
              sv = FView.byId 'csv'
              sv.view.goToPage 0

          else
            AutoForm.resetForm 'login'
            $('input[type="submit"],.mine').prop('disabled',false)
            $('#lerror').text 'Invalid Username or Password'
        return false

  profile:
    onSubmit: (doc) ->
      Meteor.users.update({_id: Meteor.userId()},{$set: {'profile.name': doc.name,'profile.email': doc.email}},(err) ->
        if ! err
          Meteor.call 'updateEmail',Meteor.userId(),doc.email
          $('#perror').text('')
          sv = FView.byId 'profileForm'
          sv.surface.addClass 'hide'
          App.events.emit 'displayHeadTabs'
          this.done()
        else
          $('#perror').text('An error Occured')

      )
      $('input[type="submit"],.profile').prop('disabled',false)
      if iOS
        sv = FView.byId 'csv'
        sv.view.goToPage 0

      return false
  changePasswordForm:
    onSuccess: (o,r,t) ->
      $('#naerror').text('')
      sv = FView.byId 'passwordForm'
      sv.surface.addClass 'hide'
      App.events.emit 'displayHeadTabs'
      sv = FView.byId 'loginForm'
      sv.surface.removeClass 'hide'
      if iOS
       sv = FView.byId 'csv'
       sv.view.goToPage 0

  newAccountForm:
    onSuccess: (o,r,t) ->
      sv = FView.byId 'af'
      sv.surface.addClass 'hide'
      App.events.emit 'displayHeadTabs'
      sv = FView.byId 'loginForm'
      sv.surface.removeClass 'hide'
      if iOS
        sv = FView.byId 'csv'
        sv.view.goToPage 0

    onError: (o,e,t) ->
      if o isnt 'validation'
        $('#naerror').text(e.reason)



App.alert = (text)  ->
  Session.set 'alert',text
  s = FView.byId('alert').surface
  s.removeClass 'hide'



