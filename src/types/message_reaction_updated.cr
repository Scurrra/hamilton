require "json"
require "./utils.cr"

# This object represents a change of a reaction on a message performed by a user.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::MessageReactionUpdated
  include Hamilton::Types::Common

  # The chat containing the message the user reacted to.
  property chat : Hamilton::Types::Chat

  # Unique identifier of the message inside the chat.
  property message_id : Int32

  # The user that changed the reaction, if the user isn't anonymous.
  property user : Hamilton::Types::User | Nil

  # The chat on behalf of which the reaction was changed, if the user is anonymous.
  property actor_chat : Hamilton::Types::Chat | Nil

  # Date of the change in Unix time.
  property date : Int32

  # Previous list of reaction types that were set by the user.
  property old_reaction : Array(Hamilton::Types::ReactionType)

  # New list of reaction types that have been set by the user.
  property new_reaction : Array(Hamilton::Types::ReactionType)
end