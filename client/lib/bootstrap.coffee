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
            $('#lerror').text('')
            sv = FView.byId 'loginForm'
            sv.surface.addClass 'hide'
            App.events.emit 'displayHeadTabs'
          else
            AutoForm.resetForm 'login'
            $('input[type="submit"],.mine').prop('disabled',false)
            $('#lerror').text('Invalid Username or Password')


        return false

App.alert = (text)  ->
  Session.set 'alert',text
  s = FView.byId('alert').surface
  s.removeClass 'hide'



