Template.password.events
  'click #pwcancel': (evt,tmp)->
    s = FView.fromTemplate tmp
    s.surface.addClass 'hide'
    AutoForm.resetForm 'changePasswordForm'

