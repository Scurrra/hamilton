require "json"
require "./utils.cr"

# This object defines the criteria used to request a suitable chat. Information about the selected chat will be shared with the bot when the corresponding button is pressed. The bot will be granted requested rights in the chat if appropriate.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::KeyboardButtonRequestChat
  include Hamilton::Types::Common

  # Signed 32-bit identifier of the request, which will be received back in the ChatShared object. Must be unique within the message.
  property request_id : Int32

  # Pass True to request a channel chat, pass False to request a group or a supergroup chat.
  property chat_is_channel : Bool

  # Pass True to request a forum supergroup, pass False to request a non-forum chat. If not specified, no additional restrictions are applied.
  property chat_is_forum : Bool | Nil

  # Pass True to request a supergroup or a channel with a username, pass False to request a chat without a username. If not specified, no additional restrictions are applied.
  property chat_has_username : Bool | Nil

  # Pass True to request a chat owned by the user. Otherwise, no additional restrictions are applied.
  property chat_created : Bool | Nil

  # A JSON-serialized object listing the required administrator rights of the user in the chat. The rights must be a superset of `bot_administrator_rights`. If not specified, no additional restrictions are applied.
  property user_administrator_rights : Hamilton::Types::ChatAdministratorRights | Nil

  # A JSON-serialized object listing the required administrator rights of the bot in the chat. The rights must be a subset of `user_administrator_rights`. If not specified, no additional restrictions are applied.
  property bot_administrator_rights : Hamilton::Types::ChatAdministratorRights | Nil

  # Pass True to request a chat with the bot as a member. Otherwise, no additional restrictions are applied.
  property bot_is_member : Bool | Nil

  # Pass True to request the chat's title.
  property request_title : Bool | Nil

  # Pass True to request the chat's username.
  property request_username : Bool | Nil

  # Pass True to request the chat's photo.
  property request_photo : Bool | Nil
end