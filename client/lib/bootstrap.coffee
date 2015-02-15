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


App.alert = (text)  ->
  Session.set 'alert',text
  s = FView.byId('alert').surface
  s.removeClass 'hide'