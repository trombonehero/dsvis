require './html-style.sass'

cytoscape = require 'cytoscape'
require('cytoscape-klay')(cytoscape)

linkedlist = require './linkedlist.coffee'

window.$ = $ = require('jquery')
window.w2ui = w2ui = require 'imports-loader?jQuery=jquery!exports-loader?w2ui!w2ui'
require '../node_modules/w2ui/w2ui.css'

window.foo = $('#ui-root').w2layout {
  name: 'dsvis'
  panels: [
    {
      type: 'top'
      content: '<h1>Data structure visualizer</h1>'
      size: 50
    },
    {
      type: 'left'
      size: 150
      resizable: true
      content: 'left'
    },
    {
      type: 'main'
      resizable: true
    },
    {
      type: 'bottom'
      content: 'Data structure visualizer vX.Y.Z'
      size: 2
    },
  ]
}

g = document.createElement('div')
g.className = 'graph'
g.style.height = '100%'
g.style.width = '100%'

w2ui['dsvis'].content('main', g)


cy = window.cy = new cytoscape {
  container: g,
  boxSelectionEnabled: false,
  autounselectify: true,
  style: require('./graph-style'),
}

layout = (dir = 'LR') ->
  cy.layout({
    name: 'klay'
    animate: true
    nodeDimensionsIncludeLabels: true
    klay: {
      direction: 'RIGHT'
      edgeRouting: 'SPLINES'
      edgeSpacingFactor: 0.1
      feedbackEdges: true
      cycleBreaking: 'INTERACTIVE'
      inLayerSpacingFactor: 0.5
      layoutHierarchy: true
      nodePlacement: 'SIMPLE'
      thoroughness: 9
    }
  }).run()

w2ui['dsvis'].content('left', $().w2sidebar {
  name: 'sidebar'
  img: null
  nodes: [
    {
      id: 'canvas'
      text: 'Canvas'
      expanded: true
      group: true
      nodes: [
        {
          id: 'canvas:clear'
          text: 'Clear'
          icon: 'fas fa-trash-alt fa-lg'
        }
        {
          id: 'canvas:layout'
          text: 'Layout'
          icon: 'fas fa-th-large fa-lg'
        }
      ]
    }
    {
      id: 'linked-list'
      text: 'Linked List'
      expanded: true
      group: true
      nodes: [
        {
          id: 'linked-list:single'
          text: 'Single'
          icon: 'fas fa-arrow-right fa-lg'
        }
        {
          id: 'linked-list:double',
          text: 'Double'
          icon: 'fas fa-exchange-alt fa-lg'
        }
      ]
    }
  ]

  onClick: (event) ->
    w2ui.sidebar.unselect event.target

    switch event.target
      when 'canvas:clear' then cy.nodes().remove()

      when 'canvas:layout' then layout()

      when 'linked-list:single' then (
        l = new linkedlist(cy, false)
        l.add_node(i) for i in [0...4]
        layout(dir = 'LR')
      )

      when 'linked-list:double' then (
        l = new linkedlist(cy, true)
        l.add_node(i) for i in [0...4]
        layout(dir = 'LR')
      )

      else
        console.log event.target
})
