require "json"
require "./utils.cr"

# Describes a service message about an option deleted from a poll.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PollOptionDeleted
  include JSON::Serializable
  include Hamilton::Types::Common

  # Message containing the poll to which the option was deleted, if known. Note that the `Message` object in this field will not contain the `reply_to_message` field even if it itself is a reply.
  property poll_message : Hamilton::Types::MaybeInaccessibleMessage | Nil

  # Unique identifier of the deleted option.
  property option_persistent_id : String

  # Option text.
  property option_text : String

  # Special entities that appear in the `option_text`.
  property option_text_entities : Array(Hamilton::Types::MessageEntity) | Nil
end
