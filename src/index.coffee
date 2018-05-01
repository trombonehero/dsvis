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
      content: '<h1>Data structure visualizer</h1><div id="toolbar"></div>'
    },
    {
      type: 'main'
      resizable: true
    }
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



$('#toolbar').w2toolbar {
  name: 'toolbar'
  items: [
    {
      type: 'menu'
      id: 'create-new'
      caption: 'Create new...'
      items: [
        {
          text: 'Singly-linked list'
          id: 'singly-linked-list'
          icon: 'icon-page'
        }
        {
          text: 'Doubly-linked list'
          id: 'doubly-linked-list'
          icon: 'icon-page'
        }
      ]
    }
    { type: 'button',  id: 'item5',  caption: 'Item 5', icon: 'fa-home' }
  ]

  onClick: (ev) ->
    switch ev.target
      when 'create-new:singly-linked-list' then (
        l = new linkedlist(cy, false)
        layout(dir = 'LR')
      )

      when 'create-new:doubly-linked-list' then (
        l = new linkedlist(cy, true)
        layout(dir = 'LR')
      )
}
