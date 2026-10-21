require "json"
require "./utils.cr"

# This object describes the access settings of a bot.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BotAccessSettings
  include JSON::Serializable
  include Hamilton::Types::Common

  # True, if only selected users can access the bot. The bot's owner can always access it.
  property is_access_restricted : Bool

  # The list of other users who have access to the bot if the access is restricted.
  property added_users : Array(Hamilton::Types::User) | Nil
end
