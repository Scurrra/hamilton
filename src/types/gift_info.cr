require "json"

# Describes a service message about a regular gift that was sent or received.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::GiftInfo
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

  # Information about the gift.
  property gift : Hamilton::Types::Gift

  # Unique identifier of the received gift for the bot; only present for gifts received on behalf of business accounts.
  property owned_gift_id : String | Nil

  # Number of Telegram Stars that can be claimed by the receiver by converting the gift; omitted if conversion to Telegram Stars is impossible.
  property convert_star_count : Int32 | Nil

  # Number of Telegram Stars that were prepaid by the sender for the ability to upgrade the gift.
  property prepaid_upgrade_star_count : Int32 | Nil

  # True, if the gift can be upgraded to a unique gift.
  property can_be_upgraded : Bool | Nil

  # Text of the message that was added to the gift.
  property text : String | Nil
  
  # Special entities that appear in the text.
  property entities : Array(Hamilton::Types::MessageEntity) | Nil

  # True, if the sender and gift text are shown only to the gift receiver; otherwise, everyone will be able to see them.
  property is_private : Bool | Nil
end