#
# Create a new linked list within a given Cytoscape canvas.
#
# ## Parameters:
# `cy`::
#   A Cytoscape graph
#
# `doubly_linked`::
#   Whether this will be a doubly-linked list (alternative: singly-linked)
#
# ## Methods:
#
# `add_node()`::
#   Add a new node to a linked list. If the graph currently has no nodes,
#   a new (empty) node will be added. Otherwise, a new node will be added with
#   an auto-incrementing ID and `next` [and `prev`] pointer[s] will be created.
#
module.exports = (cy, doubly_linked = true) ->
  n = 0
  roots =
    first: null
    last: null

  # Add a low-level Cytoscape graph node
  add_graph_node = (label, classes, parent = null) ->
    cy.add {
      group: 'nodes'
      classes: classes
      data:
        label: label
        parent: parent
    }

  add_edge = (src, dst, label = '') ->
    cy.add {
      group: 'edges'
      data:
        source: src
        target: dst
        label: label
        weight: 100.0
    }

  list_name = Math.floor(Math.random() * 0x100000000).toString(16)
  meta_node = add_graph_node list_name, 'metadata'
  pointers = window.pointers =
    first: add_graph_node 'first', 'pointer metadata', meta_node.id()
    last: add_graph_node 'last', 'pointer metadata', meta_node.id()

  {
    add_node: (value) ->
      node = add_graph_node null, 'value'
      id = node.id()

      # Is this the first node?
      if not roots.first?
        roots.first = node
        e = add_edge pointers.first.id(), id
        e.data 'weight', 200

      add_graph_node n, 'value', id

      prev = roots.last
      if prev?
        prev_id = prev.id()

        next_ptr = add_graph_node 'next', 'pointer', prev_id
        add_edge next_ptr.id(), id, 'next'

        if doubly_linked
          prev_ptr = add_graph_node 'prev', 'pointer', id
          add_edge prev_ptr.id(), prev_id, 'prev' if doubly_linked

      pointers.last.connectedEdges().remove()
      add_edge pointers.last.id(), id

      roots.last = node
      n = n + 1
  }
