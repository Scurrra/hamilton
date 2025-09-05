require "json"
require "./utils.cr"

# This object represents a forum topic.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ForumTopic
  include Hamilton::Types::Common

  # Unique identifier of the forum topic.
  property message_thread_id : Int32

  # Name of the topic.
  property name : String

  # Color of the topic icon in RGB format.
  property icon_color : Int32

  # Unique identifier of the custom emoji shown as the topic icon.
  property icon_custom_emoji_id : String | Nil
end