require "json"
require "./utils.cr"

# A placeholder, currently holds no information. Use BotFather to set up your game.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::CallbackGame
  include JSON::Serializable
  include Hamilton::Types::Common
end