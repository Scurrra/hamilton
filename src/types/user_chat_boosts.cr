require "json"
require "./utils.cr"

# This object represents a list of boosts added to a chat by a user.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::UserChatBoosts
  include Hamilton::Types::Common

  # The list of boosts added to the chat by the user.
  property boosts : Array(Hamilton::Types::ChatBoost)
end