require "json"

# This object represents a sticker set.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::StickerSet
  include JSON::Serializable

  @[JSON::Field(ignore: true)]
  property non_nil_fields : Array(String) = [] of String

  def after_initialize
    {% for field, index in @type.instance_vars.map &.name.stringify %}
    unless @{{field.id}}.nil?
      @non_nil_fields.push({{field}})
    end
    {% end %}

    @non_nil_fields.delete("non_nil_fields")
  end

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