DataStructure = require('./DataStructure')

#
# A singly- or doubly-linked list.
#
class LinkedList extends DataStructure
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
  constructor: (@cy, @doubly_linked = true) ->
    super('LinkedList')

    @all_nodes = @cy.collection()
    @roots =
      first: null
      last: null

    @name = Math.floor(Math.random() * 0x100000000).toString(16)
    @meta_node = @add_graph_node @name, 'metadata'
    meta_id = @meta_node.id()

    @pointers =
      first: @add_graph_node 'first', 'pointer metadata', meta_id

    if @doubly_linked
      @pointers.last = @add_graph_node 'last', 'pointer metadata', meta_id

  #
  # Add a new node to the linked list. If the graph currently has no nodes,
  # a new (empty) node will be added. Otherwise, a new node will be added with
  # an auto-incrementing ID and `next` [and `prev`] pointer[s] will be created.
  #
  add_node: (value) ->
    node = @add_graph_node()
    id = node.id()

    @add_graph_node value, 'value', id
    node.data('next', @add_graph_node('next', 'pointer', id).id())
    if @doubly_linked
      node.data('prev', @add_graph_node('prev', 'pointer', id).id())

    # Is this the first node?
    if not @roots.first?
      @roots.first = node
      e = @add_edge @pointers.first.id(), id
      e.data 'weight', 200

    prev = @roots.last
    if prev?
      @add_edge prev.data('next'), id, 'next'
      @add_edge node.data('prev'), prev.id(), 'prev' if @doubly_linked

    if @doubly_linked
      @pointers.last.connectedEdges().remove()
      @add_edge @pointers.last.id(), id

    @roots.last = node

  #
  # Add a low-level Cytoscape graph node (which may represent an individual
  # value, a pointer or a parent node, e.g., the ode that contains a list's
  # `first` and `last` pointers).
  #
  add_graph_node: (label = '', classNames = '', parent = null) ->
    node = @cy.add {
      group: 'nodes'
      classes: classNames
      data:
        label: label
        parent: parent
    }
    @all_nodes = @all_nodes.add node
    node

  add_edge: (src, dst, label = '') ->
    @cy.add {
      group: 'edges'
      data:
        source: src
        target: dst
        label: label
        weight: 100.0
    }

  destroy: () -> @all_nodes.remove()

module.exports = LinkedList
