require "json"
require "./utils.cr"

# This object represents the bot's name.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BotName
  include Hamilton::Types::Common

  # The bot's name.
  property name : String
end