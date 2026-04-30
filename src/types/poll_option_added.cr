require "json"
require "./utils.cr"

# Describes a service message about an option added to a poll.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PollOptionAdded
  include JSON::Serializable
  include Hamilton::Types::Common

  # Message containing the poll to which the option was added, if known. Note that the `Message` object in this field will not contain the `reply_to_message` field even if it itself is a reply.
  property poll_message : Hamilton::Types::MaybeInaccessibleMessage | Nil

  # Unique identifier of the added option.
  property option_persistent_id : String

  # Option text.
  property option_text : String

  # Special entities that appear in the `option_text`.
  property option_text_entities : Array(Hamilton::Types::MessageEntity) | Nil
end
