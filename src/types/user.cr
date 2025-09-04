require "json"

# This object represents a Telegram user or bot.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::User
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

  # Unique identifier for this user or bot.
  property id : Int64

  # True, if this user is a bot.
  property is_bot : Bool

  # User's or bot's first name.
  property first_name : String

  # User's or bot's last name.
  property last_name : String | Nil

  # User's or bot's username.
  property username : String | Nil

  # IETF language tag of the user's language.
  property language_code : String | Nil

  # True, if this user is a Telegram Premium user.
  property is_premium : Bool | Nil

  # True, if this user added the bot to the attachment menu
  property added_to_attachment_menu : Bool | Nil

  # True, if the bot can be invited to groups. Returned only in getMe.
  property can_join_groups : Bool | Nil

  # True, if privacy mode is disabled for the bot. Returned only in getMe.
  property can_read_all_group_messages : Bool | Nil

  # True, if the bot supports inline queries. Returned only in getMe.
  property supports_inline_queries : Bool | Nil

  # True, if the bot can be connected to a Telegram Business account to receive its messages. Returned only in getMe.
  property can_connect_to_business : Bool | Nil

  # True, if the bot has a main Web App. Returned only in getMe.
  property has_main_web_app : Bool | Nil
end