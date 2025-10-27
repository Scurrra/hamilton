require "json"
require "./utils.cr"

# This object represents reaction changes on a message with anonymous reactions.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::MessageReactionCountUpdated
  include JSON::Serializable
  include Hamilton::Types::Common

  # The chat containing the message.
  property chat : Hamilton::Types::Chat

  # Unique message identifier inside the chat.
  property message_id : Int32

  # Date of the change in Unix time.
  property date : Int32

  # List of reactions that are present on the message.
  property reactions : Array(Hamilton::Types::ReactionCount)
end