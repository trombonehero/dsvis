primaryColor = '#3366ff'
metaColor = '#ffcc66'
outlineColor = '#003366'
pointerColor = '#ff9999'
textColor = 'white'

module.exports = [
  {
    selector: 'node'
    style:
      'background-color': primaryColor
      #'border-color': outlineColor
      #'border-width': '2px'
      'color': textColor
      'content': 'data(id)'
      'font-size': '24pt'
      'label': 'data(label)'
      #'padding': '1em'
      #'padding-relative-to': 'width'
      'shape': 'rectangle'
      'width': '4em'
      'text-valign': 'center'
      'text-halign': 'center'
      'text-outline-color': primaryColor
      'text-outline-width': '4px'
      'text-wrap': 'wrap'
  },
  # Metadata nodes (e.g., begin/end pointers)
  {
    selector: 'node.metadata'
    style:
      'background-color': metaColor
      'text-outline-color': metaColor
  },
  # Pointers
  {
    selector: 'node.pointer'
    style:
      'background-color': pointerColor
      'text-outline-color': pointerColor
  },
  # Compound nodes
  {
    selector: '$node > node'
    style:
      'background-opacity': 0.25
      'border-style': 'dotted'
      'compound-sizing-wrt-labels': 'include'
      'text-valign': 'top'
  },
  {
    selector: 'edge'
    style:
      'color': textColor
      'control-point-distance': 5000
      'curve-style': 'bezier'
      'edge-distances': 'node-position'
      'line-color': pointerColor
      'opacity': 0.75
      'text-outline-color': pointerColor
      'text-outline-width': '2px'
      'width': 4

      'target-arrow-color': pointerColor
      'target-arrow-shape': 'triangle'
      'target-label': 'data(label)'
  },
]
