primaryColor = '#66ccff'
metaColor = '#ffcc66'
outlineColor = '#003366'

module.exports = [
  {
    selector: 'node'
    style:
      'background-color': primaryColor
      'border-color': outlineColor
      'border-width': '2px'
      'color': outlineColor
      'content': 'data(id)'
      'font-size': '18pt'
      'label': 'data(label)'
      'padding': '1em'
      'padding-relative-to': 'width'
      'shape': 'rectangle'
      'width': '4em'
      'text-valign': 'center'
      'text-halign': 'center'
      'text-outline-color': primaryColor
      'text-outline-width': '1px'
      'text-wrap': 'wrap'
  },
  # Metadata nodes (e.g., begin/end pointers)
  {
    selector: 'node.metadata'
    style:
      'background-color': metaColor
      'text-outline-color': metaColor
  },
  # Compound nodes
  {
    selector: '$node > node'
    style:
      'background-opacity': 0.25
      'compound-sizing-wrt-labels': 'include'
      'text-valign': 'top'
  },
  {
    selector: 'edge'
    style:
      'curve-style': 'bezier'
      'label': 'data(label)'
      'width': 4

      'line-color': primaryColor
      'opacity': 0.5

      'target-arrow-color': primaryColor
      'target-arrow-shape': 'triangle'
  },
]
