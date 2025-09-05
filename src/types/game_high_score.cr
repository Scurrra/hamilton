require "json"
require "./utils.cr"

# This object represents one row of the high scores table for a game.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::GameHighScore
  include Hamilton::Types::Common

  # Position in high score table for the game.
  property position : Int32

  # User.
  property user : Hamilton::Types::User

  # Score.
  property score : Int32
end