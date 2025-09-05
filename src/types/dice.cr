require "json"
require "./utils.cr"

# This object represents an animated emoji that displays a random value.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Dice
  include Hamilton::Types::Common

  # Emoji on which the dice throw animation is based.
  property emoji : String

  # Value of the dice, 1-6 for “🎲”, “🎯” and “🎳” base emoji, 1-5 for “🏀” and “⚽” base emoji, 1-64 for “🎰” base emoji.
  property value : Int32
end