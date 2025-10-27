require "json"
require "./utils.cr"

# This object represents a game. Use BotFather to create and edit games, their short names will act as unique identifiers.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Game
  include JSON::Serializable
  include Hamilton::Types::Common

  # Title of the game.
  property title : String

  # Description of the game.
  property description : String

  # Photo that will be displayed in the game message in chats.
  property photo : Array(PhotoSize)

  # Brief description of the game or high scores included in the game message. Can be automatically edited to include current high scores for the game when the bot calls `setGameScore`, or manually edited using `editMessageText`. 0-4096 characters.
  property text : String | Nil

  # Special entities that appear in text, such as usernames, URLs, bot commands, etc.
  property text_entities : Array(Hamilton::Types::MessageEntity) | Nil

  # Animation that will be displayed in the game message in chats. Upload via BotFather.
  property animation : Hamilton::Types::Animation | Nil
end