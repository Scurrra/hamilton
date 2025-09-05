require "json"
require "./utils.cr"

# The background is automatically filled based on the selected colors.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BackgroundTypeFill
  include Hamilton::Types::Common

  # Type of the background, always “fill”.
  property type : String

  # The background fill.
  property fill : Hamilton::Types::BackgroundFill

  # Dimming of the background in dark themes, as a percentage; 0-100.
  property dark_theme_dimming : Int32
end

# The background is a wallpaper in the JPEG format.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BackgroundTypeWallpaper
  include Hamilton::Types::Common

  # Type of the background, always "wallpaper".
  property type : String

  # Document with the wallpaper.
  property document : Hamilton::Types::Document

  # Dimming of the background in dark themes, as a percentage; 0-100.
  property dark_theme_dimming : Int32

  # True, if the wallpaper is downscaled to fit in a 450x450 square and then box-blurred with radius 12.
  property is_blurred : Bool | Nil

  # True, if the background moves slightly when the device is tilted.
  property is_moving : Bool | Nil
end

# The background is a .PNG or .TGV (gzipped subset of SVG with MIME type “application/x-tgwallpattern”) pattern to be combined with the background fill chosen by the user.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BackgroundTypePattern
  include Hamilton::Types::Common

  # Type of the background, always "pattern".
  property type : String

  # Document with the wallpaper.
  property document : Hamilton::Types::Document

  # The background fill that is combined with the pattern.
  property fill : Hamilton::Types::BackgroundFill

  # Intensity of the pattern when it is shown above the filled background; 0-100.
  property intensity : Int32

  # True, if the background fill must be applied only to the pattern itself. All other pixels are black in this case. For dark themes only.
  property is_inverted : Bool | Nil

  # True, if the background moves slightly when the device is tilted.
  property is_moving : Bool | Nil
end

# The background is taken directly from a built-in chat theme.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BackgroundTypeChatTheme
  include Hamilton::Types::Common

  # Type of the background, always "chat_theme".
  property type : String

  # Name of the chat theme, which is usually an emoji.
  property theme_name : String
end

# This object describes the type of a background.
alias Hamilton::Types::BackgroundType = Hamilton::Types::BackgroundTypeFill | Hamilton::Types::BackgroundTypeWallpaper | Hamilton::Types::BackgroundTypePattern | Hamilton::Types::BackgroundTypeChatTheme