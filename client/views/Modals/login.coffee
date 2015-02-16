Template.login.events
  'click #cancel': (evt,tmp)->
    $('#lerror').text('')
    s = FView.fromTemplate tmp
    s.surface.addClass 'hide'
    AutoForm.resetForm 'login'

