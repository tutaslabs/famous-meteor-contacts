

Template.appMainView.rendered = ->
  c = FView.byId 'mainCtx'
  c.context.setPerspective 2000
  App.trans = new Famous.Transitionable 0
  degtorad = 0.0174533

  cvv = FView.byId 'cvv'
  cvvm = cvv.modifier
  cvvm.transformFrom =>
    return Famous.Transform.rotateX App.trans.get()*degtorad

