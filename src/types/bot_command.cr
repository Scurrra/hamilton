require "json"

# This object represents a bot command.
#
# The following algorithm is used to determine the list of commands for a particular user viewing the bot menu. The first list of commands which is set is returned:
# Commands in the chat with the bot:
# - botCommandScopeChat + language_code
# - botCommandScopeChat
# - botCommandScopeAllPrivateChats + language_code
# - botCommandScopeAllPrivateChats
# - botCommandScopeDefault + language_code
# - botCommandScopeDefault
# 
# Commands in group and supergroup chats:
# - botCommandScopeChatMember + language_code
# - botCommandScopeChatMember
# - botCommandScopeChatAdministrators + language_code (administrators only)
# - botCommandScopeChatAdministrators (administrators only)
# - botCommandScopeChat + language_code
# - botCommandScopeChat
# - botCommandScopeAllChatAdministrators + language_code (administrators only)
# - botCommandScopeAllChatAdministrators (administrators only)
# - botCommandScopeAllGroupChats + language_code
# - botCommandScopeAllGroupChats
# - botCommandScopeDefault + language_code
# - botCommandScopeDefault
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BotCommand
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

  # Text of the command; 1-32 characters. Can contain only lowercase English letters, digits and underscores.
  property command : String

  # Description of the command; 1-256 characters.
  property description : String
end