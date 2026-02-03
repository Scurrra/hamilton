require "json"
require "./utils.cr"

# This object contains information about the color scheme for a user's name, message replies and link previews based on a unique gift.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::UniqueGiftColors
  include JSON::Serializable
  include Hamilton::Types::Common

  # Custom emoji identifier of the unique gift's model.
  property model_custom_emoji_id : String

  # Custom emoji identifier of the unique gift's symbol.
  property symbol_custom_emoji_id : String

  # Main color used in light themes; RGB format.
  property light_theme_main_color : Int32

  # List of 1-3 additional colors used in light themes; RGB format.
  property light_theme_other_colors : Array(Int32)

  # Main color used in dark themes; RGB format.
  property dark_theme_main_color : Int32

  # List of 1-3 additional colors used in dark themes; RGB format.
  property dark_theme_other_colors : Array(Int32)
end
