require "json"
require "./utils.cr"

# This object represents a chat background.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatBackground
  include JSON::Serializable
  include Hamilton::Types::Common

  # Type of the background.
  property type : Hamilton::Types::BackgroundType
end