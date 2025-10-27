require "json"
require "./utils.cr"

# This object represents the bot's description.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BotDescription
  include JSON::Serializable
  include Hamilton::Types::Common

  # The bot's description.
  property description : String
end