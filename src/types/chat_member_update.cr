require "json"

# This object represents changes in the status of a chat member.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatMemberUpdated
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

  # Chat the user belongs to.
  property chat : Hamilton::Types::Chat

  # Performer of the action, which resulted in the change.
  property from : Hamilton::Types::User

  # Date the change was done in Unix time.
  property date : Int32

  # Previous information about the chat member.
  property old_chat_member : Hamilton::Types::ChatMember

  # New information about the chat member.
  property new_chat_member : Hamilton::Types::ChatMember

  # Chat invite link, which was used by the user to join the chat; for joining by invite link events only.
  property invite_link : Hamilton::Types::ChatInviteLink | Nil

  # True, if the user joined the chat after sending a direct join request without using an invite link and being approved by an administrator.
  property via_join_request : Bool | Nil

  # True, if the user joined the chat via a chat folder invite link.
  property via_chat_folder_invite_link : Bool | Nil
end