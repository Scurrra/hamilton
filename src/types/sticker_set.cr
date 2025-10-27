require "json"
require "./utils.cr"

# This object represents a sticker set.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::StickerSet
  include JSON::Serializable
  include Hamilton::Types::Common

  # Sticker set name.
  property name : String

  # Sticker set title.
  property title : String

  # Type of stickers in the set, currently one of “regular”, “mask”, “custom_emoji”.
  property sticker_type : String

  # List of all set stickers.
  property stickrs : Array(Hamilton::Types::Sticker)

  # Sticker set thumbnail in the .WEBP, .TGS, or .WEBM format.
  property thumbnail : Hamilton::Types::PhotoSize | Nil
end