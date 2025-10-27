require "json"
require "./utils.cr"

# Describes an inline message to be sent by a user of a Mini App.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PreparedInlineMessage
  include JSON::Serializable
  include Hamilton::Types::Common

  # Unique identifier of the prepared message.
  property id : String

  # Expiration date of the prepared message, in Unix time. Expired prepared messages can no longer be used.
  property expiration_date : Int32
end