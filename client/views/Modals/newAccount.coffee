Template.newaccount.events
  'click #nacancel': (evt,tmp)->
    $('#naerror').text('')
    s = FView.fromTemplate tmp
    s.surface.addClass 'hide'
    AutoForm.resetForm 'newAccountForm'




