primaryColor = '#66ccff'
outlineColor = '#003366'

module.exports = [
  {
    selector: 'node',
    style: {
      'background-color': primaryColor,
      'border-color': outlineColor,
      'border-width': '2px',
      'color': outlineColor,
      'content': 'data(id)',
      'font-size': '18pt',
      'shape': 'rectangle',
      'width': '4em',
      'text-valign': 'center',
      'text-halign': 'center',
      'text-outline-color': primaryColor,
      'text-outline-width': '1px',
    }
  },
  ###
  {
    selector: 'node[data(root)]',
    style: {
      'background-color': 'red',
    }
  },
  ###
  {
    selector: 'edge',
    style: {
      'curve-style': 'bezier',
      'label': 'data(label)',
      'width': 4,

      'line-color': primaryColor,
      'opacity': 0.5,

      'target-arrow-color': primaryColor,
      'target-arrow-shape': 'triangle',

    }
  }
]
