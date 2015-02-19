Template.login.events

  'click #create': (evt,tmp)->

    $('#lerror').text('')
    s = FView.fromTemplate tmp
    s.surface.addClass 'hide'
    AutoForm.resetForm 'login'
    sv = FView.byId 'af'
    sv.surface.removeClass 'hide'
    # force scrollview to top


  'click #cancel': (evt,tmp)->
    $('#lerror').text('')
    s = FView.fromTemplate tmp
    s.surface.addClass 'hide'
    AutoForm.resetForm 'login'
    $('input[type="submit"],.mine').prop('disabled',false)
    if iOS
      sv = FView.byId 'csv'
      sv.view.goToPage 0



