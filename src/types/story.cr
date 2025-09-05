require "json"
require "./utils.cr"

# This object represents a story.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Story
  include Hamilton::Types::Common

  # Chat that posted the story
  property chat : Hamilton::Types::Chat
  
  # Unique identifier for the story in the chat.
  property id : Int32
end