metaColor = '#ffcc66'
nodeColor = '#999999'
nullPointerColor = '#ff3333'
outlineColor = '#003366'
pointerColor = '#3366ff'
textColor = 'white'
valueColor = '#66cc66'

module.exports = [
  {
    selector: 'node'
    style:
      'background-color': valueColor
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
      'text-outline-color': valueColor
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
  {
    selector: 'node.pointer[[degree = 0]]'
    style:
      'background-color': nullPointerColor
      'background-opacity': 0.25
      'text-outline-color': nullPointerColor
  },
  # Compound nodes
  {
    selector: '$node > node'
    style:
      'background-color': nodeColor
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
