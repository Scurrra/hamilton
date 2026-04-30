require "json"
require "./utils.cr"

# Describes a keyboard button to be used by a user of a Mini App.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PreparedKeyboardButton
  include JSON::Serializable
  include Hamilton::Types::Common

  # Unique identifier of the keyboard button.
  property id : String
end
