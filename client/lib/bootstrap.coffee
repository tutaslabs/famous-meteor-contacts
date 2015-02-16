#declare namespaces
window.App ?= {}
window.Famous ?={}


Meteor.startup  ->
  Logger.setLevel 'famous-views','info'
  Meteor.subscribe 'contacts'
  App.transitionContent =  'slideWindow'
  Session.set 'currentHeadFootContentTemplate','contactScrollView'
  App.click = false
  App.events = new Famous.EventHandler
  Session.set 'navIcon','<i class="fa fa-plus"></i>'
  Session.set 'alert','none'


AutoForm.hooks
  login:
    onSubmit: (doc) ->
        Meteor.loginWithPassword doc.username,doc.password,(err) =>
          if ! err

            this.done()
            iOS = /(iPad|iPhone|iPod)/g.test(navigator.userAgent)
            if iOS
              $('.famous-container').remove()
              window.location.href = '/'
            $('#lerror').text('')
            sv = FView.byId 'loginForm'
            sv.surface.addClass 'hide'
            App.events.emit 'displayHeadTabs'
          else
            AutoForm.resetForm 'login'
            $('input[type="submit"],.mine').prop('disabled',false)
            $('#lerror').text('Invalid Username or Password')
        return false
  profile:
    onSubmit: (doc) ->
      Meteor.users.update({_id: Meteor.userId()},{$set: {'profile.name': doc.name,'profile.email': doc.email}},(err) ->
        if ! err
          $('#perror').text('')
          sv = FView.byId 'profileForm'
          sv.surface.addClass 'hide'
          App.events.emit 'displayHeadTabs'
          this.done()
        else
          $('#perror').text('An error Occured')

      )
      $('input[type="submit"],.profile').prop('disabled',false)
      return false
  changePasswordForm:
    onSuccess: (o,r,t) ->
      sv = FView.byId 'passwordForm'
      sv.surface.addClass 'hide'
      App.events.emit 'displayHeadTabs'
      sv = FView.byId 'loginForm'
      sv.surface.removeClass 'hide'


App.alert = (text)  ->
  Session.set 'alert',text
  s = FView.byId('alert').surface
  s.removeClass 'hide'



