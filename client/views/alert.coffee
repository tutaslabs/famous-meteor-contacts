Template.alert.helpers
  'text': ->
     Session.get 'alert'

Template.alert.events
  'click #ab':  (evt,tmpl) ->
    s = FView.byId('alert').surface
    s.addClass 'hide'
