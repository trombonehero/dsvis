#
# Base class for data structures that we can represent in our tool.
#
# TODO: very soon, these data structures will be able to expose the operations
#       they support to the UI
#
class DataStructure
  constructor: (@name) ->

module.exports = DataStructure
