require "json"
require "./utils.cr"

# This object contains information about the creation, token update, or owner update of a bot that is managed by the current bot.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ManagedBotUpdated
  include JSON::Serializable
  include Hamilton::Types::Common

  # User that created the bot.
  property user : Hamilton::Types::User

  # Information about the bot. The bot's token can be fetched using the method `getManagedBotToken`.
  property bot : Hamilton::Types::User
end
