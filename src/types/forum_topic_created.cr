require "json"
require "./utils.cr"

# This object represents a service message about a new forum topic created in the chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ForumTopicCreated
  include JSON::Serializable
  include Hamilton::Types::Common

  # Name of the topic.
  property name : String

  # Color of the topic icon in RGB format.
  property icon_color : Int32

  # Unique identifier of the custom emoji shown as the topic icon.
  property icon_custom_emoji_id : String | Nil
end