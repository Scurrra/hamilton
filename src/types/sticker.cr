require "json"

# This object represents a sticker.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Sticker
  include JSON::Serializable

  def initialize(**params)
    {%begin%}

    {% properties = {} of Nil => Nil %}
    {% for ivar in @type.instance_vars %}
      {% unless ivar.id.stringify == "non_nil_fields" %}
      {%
        properties[ivar.id] = {
          key: ivar.id.stringify,
          type: ivar.type,
        }
      %}
      {% end %}
    {% end %}
    
    {% for name, value in properties %}
      %var{name} = uninitialized {{value[:type]}}
      %found{name} = false
    {% end %}
  
    params_keys, i = params.keys, 0
    while i < params_keys.size
      key = params_keys[i]
      case key.to_s
      {% for name, value in properties %}
      when {{value[:key]}}
        if params.has_key?({{value[:key]}})
          if param = params[{{value[:key]}}]?
            unless typeof(param) <= {{value[:type]}}
              raise Hamilton::Errors::FieldTypeMissmatch.new(key, {{value[:type]}}, typeof(param))
            end

            %var{name} = param
            %found{name} = true
          else
            raise Hamilton::Errors::FieldTypeMissmatch.new(key, {{value[:type]}}, Nil)
          end
        end
      {% end %}
      else
        raise Hamilton::Errors::UnknownField.new(key)
      end
      i += 1
    end

    {% for name, value in properties %}
      if %found{name}
        @{{name}} = %var{name}
      {% unless Nil < value[:type] %}
      else
        raise Hamilton::Errors::MissingField.new({{name.stringify}})
      {% end %}
      end
    {% end %}

    #{%debug%}
    {%end%}
    
    after_initialize
  end

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