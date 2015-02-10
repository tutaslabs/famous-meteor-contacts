Template.header.rendered = ->

    labs = FView.byId('label').surface
    App.events.on 'displayUpdate',->
      Session.set 'navIcon','<i class="fa fa-chevron-left"></i>'
      labs.setContent 'Update Contact'
