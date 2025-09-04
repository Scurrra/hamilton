require "json"

# Represents an invite link for a chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatInviteLink
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

  # The invite link. If the link was created by another chat administrator, then the second part of the link will be replaced with “…”.
  property invite_link : String

  # Creator of the link.
  property creator : Hamilton::Types::User

  # True, if users joining the chat via the link need to be approved by chat administrators.
  property creates_join_request : Bool

  # True, if the link is primary.
  property is_primary : Bool

  # True, if the link is revoked.
  property is_revoked : Bool

  # Invite link name.
  property name : String | Nil

  # Point in time (Unix timestamp) when the link will expire or has been expired.
  property expire_date : Int32 | Nil

  # The maximum number of users that can be members of the chat simultaneously after joining the chat via this invite link; 1-99999.
  property member_limit : Int32 | Nil

  # Number of pending join requests created using this link.
  property pending_join_request_count : Int32 | Nil

  # The number of seconds the subscription will be active for before the next payment.
  property subscription_period : Int32 | Nil

  # The amount of Telegram Stars a user must pay initially and after each subsequent subscription period to be a member of the chat using the link.
  property subscription_price : Int32 | Nil
end