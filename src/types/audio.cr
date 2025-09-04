require "json"

# This object represents an audio file to be treated as music by the Telegram clients.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Audio
  include JSON::Serializable

  def initialize(**params)
    {%begin%}
    {% for var, index in @type.instance_vars %}
    {% unless var.name.stringify == "non_nil_fields" %}
    @{{var.name}} = params[{{var.name.stringify}}]?
    {% end %}
    {% end %}
    {%debug%}
    {%end%}

    # {%begin%}

    # {% properties = {} of Nil => Nil %}
    # {% for ivar in @type.instance_vars %}
    #   {% unless ivar.id.stringify == "non_nil_fields" %}
    #   {%
    #     properties[ivar.id] = {
    #       key: ivar.id.stringify,
    #       type: ivar.type,
    #     }
    #   %}
    #   {% end %}
    # {% end %}
    
    # {% for name, value in properties %}
    #   %var{name} = uninitialized {{value[:type]}}
    #   %found{name} = false
    # {% end %}
  
    # params_keys, i = params.keys, 0
    # while i < params_keys.size
    #   key = params_keys[i]
    #   case key.to_s
    #   {% for name, value in properties %}
    #   when {{value[:key]}}
    #     if params.has_key?({{value[:key]}})
    #       if param = params[{{value[:key]}}]?
    #         pp typeof(param)
    #         unless typeof(param) <= {{value[:type]}}
    #           raise Hamilton::Errors::FieldTypeMissmatch.new(key, {{value[:type]}}, typeof(param))
    #         end

    #         # %var{name} = {{value[:type]}}.from_json param.to_json
    #         # %var{name} = {{value[:type]}}.cast param
    #         %var{name} = param
    #         %found{name} = true
    #       else
    #         unless Nil < {{value[:type]}}
    #           raise Hamilton::Errors::FieldTypeMissmatch.new(key, {{value[:type]}}, Nil)
    #         end
    #       end
    #     end
    #   {% end %}
    #   else
    #     raise Hamilton::Errors::UnknownField.new(key)
    #   end
    #   i += 1
    # end

    # {% for name, value in properties %}
    #   if %found{name}
    #     @{{name}} = %var{name}
    #   {% unless Nil < value[:type] %}
    #   else
    #     raise Hamilton::Errors::MissingField.new({{name.stringify}})
    #   {% end %}
    #   end
    # {% end %}

    # {%end%}
    
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

  # Duration of the audio in seconds as defined by the sender.
  property duration : Int32

  # Performer of the audio as defined by the sender or by audio tags.
  property performer : String | Nil

  # Title of the audio as defined by the sender or by audio tags.
  property title : String | Nil

  # Original filename as defined by the sender.
  property file_name : String | Nil

  # MIME type of the file as defined by the sender.
  property mime_type : String | Nil

  # File size in bytes.
  property file_size : Int64 | Nil

  # Thumbnail of the album cover to which the music file belongs.
  property thumbnail : Hamilton::Types::PhotoSize | Nil
end