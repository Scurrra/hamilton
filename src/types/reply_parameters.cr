require "json"

# Describes reply parameters for the message that is being sent.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ReplyParameters
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

  # Identifier of the message that will be replied to in the current chat, or in the chat chat_id if it is specified.
  property message_id : Int32

  # If the message to be replied to is from a different chat, unique identifier for the chat or username of the channel (in the format @channelusername). Not supported for messages sent on behalf of a business account and messages from channel direct messages chats.
  property chat_id : String | Int32 | Nil

  # Pass True if the message should be sent even if the specified message to be replied to is not found. Always False for replies in another chat or forum topic. Always True for messages sent on behalf of a business account.
  property allow_sending_without_reply : Bool | Nil

  # Quoted part of the message to be replied to; 0-1024 characters after entities parsing. The quote must be an exact substring of the message to be replied to, including bold, italic, underline, strikethrough, spoiler, and custom_emoji entities. The message will fail to send if the quote isn't found in the original message.
  property quote : String | Nil

  # Mode for parsing entities in the quote.
  property quote_parse_mode : String | Nil

  # A JSON-serialized list of special entities that appear in the quote. It can be specified instead of quote_parse_mode.
  property quote_entities : Array(Hamilton::Types::MessageEntity) | Nil

  # Position of the quote in the original message in UTF-16 code units.
  property quote_position : Int32 | Nil

  # Identifier of the specific checklist task to be replied to.
  property checklist_task_id : Int32 | Nil
end