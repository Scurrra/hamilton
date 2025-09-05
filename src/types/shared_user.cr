require "json"
require "./utils.cr"

# This object contains information about a user that was shared with the bot using a KeyboardButtonRequestUsers button.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::SharedUser
  include Hamilton::Types::Common

  # Identifier of the shared user. The bot may not have access to the user and could be unable to use this identifier, unless the user is already known to the bot by some other means.
  property user_id : Int64

  # First name of the user, if the name was requested by the bot.
  property first_name : String | Nil

  # Last name of the user, if the name was requested by the bot.
  property last_name : String | Nil

  # Username of the user, if the username was requested by the bot.
  property username : String | Nil

  # Available sizes of the chat photo, if the photo was requested by the bot.
  property photo : Array(Hamilton::Types::PhotoSize) | Nil
end