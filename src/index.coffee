require './html-style.sass'

cytoscape = require 'cytoscape'
require('cytoscape-klay')(cytoscape)

linkedlist = require './linkedlist.coffee'

window.$ = $ = require('jquery')
window.w2ui = w2ui = require 'imports-loader?jQuery=jquery!exports-loader?w2ui!w2ui'
require '../node_modules/w2ui/w2ui.css'

$('#ui-root').w2layout {
  name: 'dsvis'
  onResize: (event) -> cy.resize() if cy?
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
      type: 'right'
      size: 200
      hidden: true
      resizable: true
      toolbar:
        items: [
          { type: 'spacer' }
          {
            type: 'button'
            id: 'close'
            icon: 'fas fa-angle-double-right fa-lg'
          }
        ]
        onClick: (event) -> this.owner.hide('right')
    },
    {
      type: 'bottom'
      content: 'dsvis v' + require('../package.json').version
      size: 2
    },
  ]
}

g = document.createElement('div')
g.className = 'graph'
g.style.height = '100%'
g.style.width = '100%'

ui = w2ui['dsvis']

ui.content('main', g)
ui.content('left', $().w2sidebar {
  name: 'sidebar'
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
          id: 'canvas:layout:lr'
          text: 'Layout (LR)'
          icon: 'fas fa-angle-double-right fa-lg'
        }
        {
          id: 'canvas:layout:tb'
          text: 'Layout (TB)'
          icon: 'fas fa-angle-double-down fa-lg'
        }
        {
          id: 'canvas:controls:show'
          text: 'Show controls'
          icon: 'fas fa-list fa-lg'
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
      when 'canvas:clear' then clear()
      when 'canvas:controls:show' then ui.show 'right'
      when 'canvas:layout:lr' then layout('RIGHT')
      when 'canvas:layout:tb' then layout('DOWN')

      when 'linked-list:single' then (
        l = new linkedlist(cy, false)
        l.add_node(i) for i in [0...4]
        layout('RIGHT')

        createControlPanel l, 'SLL: ' + l.name
      )

      when 'linked-list:double' then (
        l = new linkedlist(cy, true)
        l.add_node(i) for i in [0...4]
        layout('RIGHT')

        createControlPanel l, 'DLL: ' + l.name
      )

      else
        console.log event.target
})

controls = document.createElement 'div'
ui.content('right', controls)


clear = () ->
  cy.nodes().remove()
  while (controls.firstChild)
    controls.removeChild controls.firstChild

createControlPanel = (ds, title) ->
  form = document.createElement 'div'

  t = document.createElement 'div'
  t.className = 'w2ui-panel-title'
  $(t).w2toolbar {
    name: 'controls_' + ds.name
    items: [
      { text: title, }
      { type: 'spacer' }
      {
        type: 'button'
        id: 'delete'
        icon: 'fas fa-trash-alt fa-lg'
      }
    ]
    onClick: (event) ->
      if event.target == 'delete'
        ds.destroy()
        controls.removeChild form
  }

  form.appendChild t

  fields = document.createElement 'div'
  fields.innerHTML = '''
    <div class="w2ui-field">
      <label>Find:</label>
      <div><input size="2"/></div>
    </div>

    <div class="block">
      <b>Add node</b>
      <div class="w2ui-field">
        <label>Value:</label>
        <div><input size="2"/></div>
      </div>
      <div class="w2ui-field">
        <label>At:</label>
        <div><input size="2" value="0"/></div>
      </div>
      <div class="w2ui-field">
        <label></label>
        <div><button>Add</button></div>
      </div>
    </div>
    '''

  form.appendChild fields
  controls.appendChild form

  ui.show('right')


cy = window.cy = new cytoscape {
  container: g,
  boxSelectionEnabled: false,
  autounselectify: true,
  style: require('./graph-style'),
}

layout = (direction = 'RIGHT') ->
  cy.layout({
    name: 'klay'
    animate: true
    nodeDimensionsIncludeLabels: true
    klay: {
      direction: direction
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
