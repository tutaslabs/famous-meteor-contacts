Template.login.events

  'click #create': (evt,tmp)->

    $('#lerror').text('')
    s = FView.fromTemplate tmp
    s.surface.addClass 'hide'
    AutoForm.resetForm 'login'
    sv = FView.byId 'af'
    sv.surface.removeClass 'hide'



  'click #cancel': (evt,tmp)->
    s = FView.fromTemplate tmp
    s.surface.addClass 'hide'
    $('#lerror').text('')
    AutoForm.resetForm 'login'
    $('input[type="submit"],.mine').prop('disabled',false)
    if iOS
      sv = FView.byId 'csv'
      sv.view.goToPage 0

  'click #forgot': (evt,tmp)->
    un = AutoForm.getFieldValue 'login','username'
    if ! un
      $('#lerror').text "Please Enter Your Username"
    else if un is 'demo'
      $('#lerror').text "Can not change Demo account"
    else
      s = FView.fromTemplate tmp
      s.surface.addClass 'hide'
      $('#lerror').text('')
      AutoForm.resetForm 'login'
      $('input[type="submit"],.mine').prop('disabled',false)
      if iOS
        sv = FView.byId 'csv'
        sv.view.goToPage 0
      Meteor.call 'sendPasswordResetEmail',un
      App.alert 'Check your email for a reset link.'





