require "json"
require "./utils.cr"

# Represents a reaction added to a message along with the number of times it was added.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ReactionCount
  include JSON::Serializable
  include Hamilton::Types::Common

  # Type of the reaction.
  property type : Hamilton::Types::ReactionType

  # Number of times the reaction was added.
  property total_count : Int32
end