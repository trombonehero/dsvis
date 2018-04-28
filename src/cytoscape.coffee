###
# Common Cytoscape initialization code
###

cytoscape = require 'cytoscape'
cydagre = require 'cytoscape-dagre'
cydagre cytoscape

cy = null
n = 0

#
# Create a new Cytoscape graph within the specified HTML DOM element.
# This graph will be augmented with additional methods:
#
# `add_node(id, label = null)`::
#   Add a new node to the graph with the given ID and (optional) label.
#   If no label is specified, it will be set to the given ID.
#
# `add_edge(source_id, dest_id, label = '')`::
#   Add an edge from one node to another, with an optional label.
#
# `add_linked(doubly_linked = true)`::
#   Add a new node to a linked list. If the graph currently has no nodes,
#   a new (empty) node will be added. Otherwise, a new node will be added with
#   an auto-incrementing ID and `next` and `prev` pointers will be created
#   (if `doubly_linked` is `false`, only `next` will be created).
#
cytoscape_graph = (element) ->
  cy = cytoscape {
    container: element,
    boxSelectionEnabled: false,
    autounselectify: true,
    style: require('./graph-style'),
  }

  roots = {}

  cy.add_node = (id, label = null, parent = null) ->
    label = id if label is null
    node = { group: 'nodes', data: { id: id, label: label, parent: parent }}

    cy.add node

  cy.add_edge = (src, dst, label = '') ->
    cy.add { group: 'edges', data: { source: src, target: dst, label: label }}

  cy.add_linked = (doubly_linked = true) ->
    # Get (or create) the meta-node that represents the whole list.
    list = cy.$('#list')
    if list.length == 0
      list = cy.add_node 'list', ''
      cy.add_node 'list-first', 'first', 'list'
      cy.add_node 'list-last', 'last', 'list'

    id = n
    node = cy.add_node id

    # Is this the first node?
    if n == 0
      roots.first = node
      cy.add_edge 'list-first', id

    prev = roots.last
    if prev
      prev_id = prev.id()
      cy.add_edge prev_id, id, 'next'
      cy.add_edge id, prev_id, 'prev' if doubly_linked

    roots.last = node
    cy.$('edge[source="list-last"]').remove()
    cy.add_edge 'list-last', id

    n = n + 1

  cy.resize()

module.exports = cytoscape_graph
