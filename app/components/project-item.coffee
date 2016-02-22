`import Ember from 'ember';`

ProjectItem = Ember.Component.extend
  classNames: ['project-item']
  classNameBindings: ['project.isColorDark:is-dark']

  paths: [
    from: 'M 0 200 l 100 -25 l 50 25 l 150 -37.5 l 50 25 l 50 -12.5 V 400 H 0 Z'
    to: 'M 0 400 L 100 400 L 150 400 L 300 400 L 350 400 L 400 400 V 400 H 0 Z'
  ,
    from: 'M 0 200 v -20 l 50 -12.5 l 100 37.5 l 50 -12.5 l 100 12.5 l 100 -25 V 400 H 0 Z'
    to: 'M 0 400 V 400 L 50 400 L 150 400 L 200 400 L 300 400 L 400 400 V 400 H 0 Z'
  ,
    from: 'M 0 200 v -25 l 50 -25 l 75 37.5 l 125 -12.5 l 100 12.5 l 50 -12.5 V 400 H 0 Z'
    to: 'M 0 400 V 400 L 50 400 L 125 400 L 250 400 L 350 400 L 400 400 V 400 H 0 Z'
  ]

  path: (->
    index = @get('index') % @get('paths.length')
    @get('paths').objectAt(index)
  ).property('index', 'paths.[]').readOnly()

  bindHover: (->
    @$().on 'mouseenter.project-item', =>
      @animate @get('path').to

    @$().on 'mouseleave.project-item', =>
      @animate @get('path').from
  ).on('didInsertElement')

  unbindHover: (->
    @$().off('mouseenter.project-item')
    @$().off('mouseleave.project-item')
  ).on('willRemoveElement')

  animate: (path) ->
    snapElement = Snap(@$('svg')[0]).select('path')
    snapElement.animate({path: path}, 250, mina.easeinout)

`export default ProjectItem;`