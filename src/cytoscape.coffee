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
#   If no label is specified, it will be set to the given ID. If this is the
#   first node in the graph, it will be set as the graph's root.
#
# `add_edge(source_id, dest_id, label = '')`::
#   Add an edge from one node to another, with an optional label.
#
# `add_linked(doubly_linked = true)`::
#   Add a new node to a linked list. If the graph currently has no nodes,
#   a new (root) node will be added. Otherwise, a new node will be added with
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

  cy.add_node = (id, label) ->
    is_root = cy.nodes().length == 0
    label = id if label is null
    node = { data: { id: id, label: label, root: is_root }}

    cy.add node
    cy.root = node if is_root

  cy.add_edge = (src, dst, label = '') ->
    cy.add { data: { source: src, target: dst, label: label }}

  cy.add_linked = (doubly_linked = true) ->
    id = n
    node = cy.add_node(id)

    if n > 0
      prev_id = (n - 1)
      cy.add_edge prev_id, id, 'next'
      cy.add_edge id, prev_id, 'prev' if doubly_linked

    n = n + 1

  cy.resize()

module.exports = cytoscape_graph
