require "json"
require "./utils.cr"

# Represents a location to which a chat is connected.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatLocation
  include Hamilton::Types::Common

  # The location to which the supergroup is connected. Can't be a live location.
  property location : Hamilton::Types::Location

  # Location address; 1-64 characters, as defined by the chat owner.
  property address : String
end