require "json"
require "./utils.cr"

# This object represents a Telegram user or bot.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::User
  include JSON::Serializable
  include Hamilton::Types::Common

  # Unique identifier for this user or bot.
  property id : Int64

  # True, if this user is a bot.
  property is_bot : Bool

  # User's or bot's first name.
  property first_name : String

  # User's or bot's last name.
  property last_name : String | Nil

  # User's or bot's username.
  property username : String | Nil

  # IETF language tag of the user's language.
  property language_code : String | Nil

  # True, if this user is a Telegram Premium user.
  property is_premium : Bool | Nil

  # True, if this user added the bot to the attachment menu
  property added_to_attachment_menu : Bool | Nil

  # True, if the bot can be invited to groups. Returned only in getMe.
  property can_join_groups : Bool | Nil

  # True, if privacy mode is disabled for the bot. Returned only in getMe.
  property can_read_all_group_messages : Bool | Nil

  # True, if the bot supports inline queries. Returned only in getMe.
  property supports_inline_queries : Bool | Nil

  # True, if the bot can be connected to a Telegram Business account to receive its messages. Returned only in getMe.
  property can_connect_to_business : Bool | Nil

  # True, if the bot has a main Web App. Returned only in getMe.
  property has_main_web_app : Bool | Nil
end