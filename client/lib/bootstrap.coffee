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