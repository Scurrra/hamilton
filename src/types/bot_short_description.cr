require "json"
require "./utils.cr"

# This object represents the bot's short description.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BotShortDescription
  include Hamilton::Types::Common

  # The bot's short description.
  property short_description : String
end