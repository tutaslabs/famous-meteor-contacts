Template.password.events
  'click #pwcancel': (evt,tmp)->
    s = FView.fromTemplate tmp
    s.surface.addClass 'hide'
    AutoForm.resetForm 'changePasswordForm'
    if iOS
      sv = FView.byId 'csv'
      sv.view.goToPage 0

