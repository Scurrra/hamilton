require "json"
require "./utils.cr"

# This object represents an inline button that switches the current user to inline mode in a chosen chat, with an optional default inline query.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::SwitchInlineQueryChosenChat
  include JSON::Serializable
  include Hamilton::Types::Common

  # The default inline query to be inserted in the input field. If left empty, only the bot's username will be inserted.
  property query : String | Nil

  # True, if private chats with users can be chosen.
  property allow_user_chats	: Bool | Nil

  # True, if private chats with bots can be chosen.
  property allow_bot_chats : Bool | Nil

  # True, if group and supergroup chats can be chosen.
  property allow_group_chats : Bool | Nil

  # True, if channel chats can be chosen.
  property allow_channel_chats : Bool | Nil
end