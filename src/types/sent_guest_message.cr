require "json"
require "./utils.cr"

# Describes an inline message sent by a guest bot.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::SentGuestMessage
  include JSON::Serializable
  include Hamilton::Types::Common

  # Identifier of the sent inline message.
  property inline_message_id : String | Nil
end
