require "json"

# This object describes a sticker to be added to a sticker set.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InputSticker
  include JSON::Serializable

  # List of available non-nil fields.
  @[JSON::Field(ignore: true)]
  property non_nil_fields : Array(String) = [] of String

  # :nodoc:
  def after_initialize
    {% for field, index in @type.instance_vars.map &.name.stringify %}
    unless @{{field.id}}.nil?
      @non_nil_fields.push({{field}})
    end
    {% end %}

    @non_nil_fields.delete("non_nil_fields")
  end

  # The added sticker. Pass a `file_id` as a String to send a file that already exists on the Telegram servers, pass an HTTP URL as a String for Telegram to get a file from the Internet, or pass `attach://<file_attach_name>` to upload a new file using `multipart/form-data` under `<file_attach_name>` name. Animated and video stickers can't be uploaded via HTTP URL.
  property sticker : String

  # Format of the added sticker, must be one of “static” for a .WEBP or .PNG image, “animated” for a .TGS animation, “video” for a .WEBM video.
  property format : String

  # List of 1-20 emoji associated with the sticker.
  property emoji_list : Array(String)

  # Position where the mask should be placed on faces. For “mask” stickers only.
  property mask_position : Hamilton::Types::MaskPosition | Nil

  # List of 0-20 search keywords for the sticker with total length of up to 64 characters. For “regular” and “custom_emoji” stickers only.
  property keywords : Array(String) | Nil
end