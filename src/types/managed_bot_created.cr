require "json"
require "./utils.cr"

# This object contains information about the bot that was created to be managed by the current bot.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ManagedBotCreated
  include JSON::Serializable
  include Hamilton::Types::Common

  # Information about the bot. The bot's token can be fetched using the method `getManagedBotToken`.
  property bot : Hamilton::Types::User
end
