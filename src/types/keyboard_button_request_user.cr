require "json"

# This object defines the criteria used to request suitable users. Information about the selected users will be shared with the bot when the corresponding button is pressed.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::KeyboardButtonRequestUsers
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

  # Signed 32-bit identifier of the request that will be received back in the UsersShared object. Must be unique within the message.
  property request_id : Int32

  # Pass True to request bots, pass False to request regular users. If not specified, no additional restrictions are applied.
  property user_is_bot : Bool | Nil

  # Pass True to request premium users, pass False to request non-premium users. If not specified, no additional restrictions are applied.
  property user_is_premium : Bool | Nil

  # The maximum number of users to be selected; 1-10. Defaults to 1.
  property max_quantity : Int32 | Nil

  # Pass True to request the users' first and last names.
  property request_name : Bool | Nil

  # Pass True to request the users' usernames.
  property request_username : Bool | Nil

  # Pass True to request the users' photos.
  property request_photo : Bool | Nil
end