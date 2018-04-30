#
# Create a new linked list within a given Cytoscape canvas.
#
# ## Parameters:
# `cy`::
#   A Cytoscape graph
#
# ## Methods:
#
# `add_linked(doubly_linked = true)`::
#   Add a new node to a linked list. If the graph currently has no nodes,
#   a new (empty) node will be added. Otherwise, a new node will be added with
#   an auto-incrementing ID and `next` and `prev` pointers will be created
#   (if `doubly_linked` is `false`, only `next` will be created).
#
module.exports = (cy) ->
  n = 0
  roots =
    first: null
    last: null

  add_node = (label, parent = null) ->
    cy.add { group: 'nodes', data: { label: label, parent: parent }}

  add_edge = (src, dst, label = '') ->
    cy.add { group: 'edges', data: { source: src, target: dst, label: label }}

  meta_node = add_node ''
  pointers = window.pointers =
    first: add_node 'first', meta_node.id()
    last: add_node 'last', meta_node.id()

  {
    add_linked: (doubly_linked = true) ->
      node = add_node n
      id = node.id()

      # Is this the first node?
      if not roots.first?
        roots.first = node
        add_edge pointers.first.id(), id

      prev = roots.last
      if prev?
        prev_id = prev.id()
        add_edge prev_id, id, 'next'
        add_edge id, prev_id, 'prev' if doubly_linked

      pointers.last.connectedEdges().remove()
      add_edge pointers.last.id(), id

      roots.last = node
      n = n + 1
  }
