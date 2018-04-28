#
# Create a new linked list within a given Cytoscape canvas.
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
  roots = {}

  add_node = (id, label = null, parent = null) ->
    label = id if label is null
    cy.add { group: 'nodes', data: { id: id, label: label, parent: parent }}

  add_edge = (src, dst, label = '') ->
    cy.add { group: 'edges', data: { source: src, target: dst, label: label }}

  {
    add_linked: (doubly_linked = true) ->
      # Get (or create) the meta-node that represents the whole list.
      list = cy.$('#list')
      if list.length == 0
        list = add_node 'list', ''
        add_node 'list-first', 'first', 'list'
        add_node 'list-last', 'last', 'list'

      id = n
      node = add_node id

      # Is this the first node?
      if n == 0
        roots.first = node
        add_edge 'list-first', id

      prev = roots.last
      if prev
        prev_id = prev.id()
        add_edge prev_id, id, 'next'
        add_edge id, prev_id, 'prev' if doubly_linked

      roots.last = node
      cy.$('edge[source="list-last"]').remove()
      add_edge 'list-last', id

      n = n + 1
  }
