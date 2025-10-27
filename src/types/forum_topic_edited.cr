require "json"
require "./utils.cr"

# This object represents a service message about an edited forum topic.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ForumTopicEdited
  include JSON::Serializable
  include Hamilton::Types::Common

  # New name of the topic, if it was edited.
  property name : String | Nil

  # New identifier of the custom emoji shown as the topic icon, if it was edited; an empty string if the icon was removed.
  property icon_custom_emoji_id : String | Nil
end