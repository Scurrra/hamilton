require "json"
require "./utils.cr"

# This object represents a sticker.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Sticker
  include Hamilton::Types::Common

  # Identifier for this file, which can be used to download or reuse the file.
  property file_id : String

  # Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.
  property file_unique_id : String

  # Type of the sticker, currently one of “regular”, “mask”, “custom_emoji”. The type of the sticker is independent from its format, which is determined by the fields `is_animated` and `is_video`.
  property type : String

  # Sticker width.
  property width : Int32

  # Sticker height.
  property height : Int32

  # True, if the sticker is animated.
  property is_animated : Bool

  # True, if the sticker is a video sticker.
  property is_video : Bool

  # Sticker thumbnail in the .WEBP or .JPG format.
  property thumbnail : Hamilton::Types::PhotoSize | Nil

  # Emoji associated with the sticker.
  property emoji : String | Nil

  # Name of the sticker set to which the sticker belongs.
  property set_name : String | Nil

  # For premium regular stickers, premium animation for the sticker.
  property premium_animation : Hamilton::Types::File | Nil

  # For mask stickers, the position where the mask should be placed.
  property mask_position : Hamilton::Types::MaskPosition | Nil

  # For custom emoji stickers, unique identifier of the custom emoji.
  property custom_emoji_id : String | Nil

  # True, if the sticker must be repainted to a text color in messages, the color of the Telegram Premium badge in emoji status, white color on chat photos, or another appropriate color in other places.
  property needs_repainting : Bool | Nil

  # File size in bytes.
  property file_size : Int32 | Nil
end