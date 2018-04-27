require './html-style.sass'

$ = require 'jquery'

cytoscape_graph = require './cytoscape.coffee'

GoldenLayout = require 'golden-layout'
require 'golden-layout/src/less/goldenlayout-base.less'
require 'golden-layout/src/less/goldenlayout-light-theme.less'

gl = new GoldenLayout({
  settings: {
    hasHeaders: false,
  },
  content: [{
    type: 'column',
    content: [
      { type: 'component', componentName: 'graph' },
      { type: 'component', componentName: 'bottom' },
    ]
  }]
})

gl.on 'initialised', () -> cy = window.cy = new cytoscape_graph $('.graph')

gl.registerComponent 'graph', (container, _) ->
  container.setTitle 'Graph'
  container.getElement().html '<div class="graph"/>'

button = (label, callback) ->
  b = document.createElement('button')
  b.innerText = label
  b.onclick = callback
  b

layout = (dir = 'LR') ->
  cy.layout({ name: 'dagre', rankDir: dir, animate: true }).run()

gl.registerComponent 'bottom', (container, _) ->
  bottom = container.getElement()

  bottom.append button 'LR', (ev) -> layout(dir = 'LR')
  bottom.append button 'TB', (ev) -> layout(dir = 'TB')

  bottom.append button 'Linked list', (ev) ->
    cy.add_linked() for i in [0..8]
    layout(dir = 'LR')

  bottom.append button 'Add linked', (ev) ->
    cy.add_linked()
    layout()

  b = bottom.append button 'Tree', (ev) ->
    cy.add_node(i) for i in [0..12]
    cy.add_edge(0, 1)
    cy.add_edge(0, 2)
    cy.add_edge(0, 3)

    cy.add_edge(1, 4)
    cy.add_edge(1, 5)
    cy.add_edge(1, 6)

    cy.add_edge(2, 7)
    cy.add_edge(2, 8)
    cy.add_edge(2, 9)

    cy.add_edge(3, 10)
    cy.add_edge(3, 11)
    cy.add_edge(3, 12)

    layout(dir = 'TB')

  gl.on 'initialised', () ->
    container.setSize 0, 28
    cy.resize() if cy

gl.init()
