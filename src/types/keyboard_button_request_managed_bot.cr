require "json"
require "./utils.cr"

# This object defines the parameters for the creation of a managed bot. Information about the created bot will be shared with the bot using the update `managed_bot` and a `Message` with the field `managed_bot_created`.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::KeyboardButtonRequestManagedBot
  include JSON::Serializable
  include Hamilton::Types::Common

  # Signed 32-bit identifier of the request. Must be unique within the message.
  property request_id : Int32

  # Suggested name for the bot.
  property suggested_name : String | Nil

  # Suggested username for the bot.
  property suggested_username : String | Nil
end
