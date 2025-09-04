require "json"

# Represents the rights of a business bot.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BusinessBotRights
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

  # True, if the bot can send and edit messages in the private chats that had incoming messages in the last 24 hours.
  property can_reply : Bool | Nil

  # True, if the bot can mark incoming private messages as read.
  property can_read_messages : Bool | Nil

  # True, if the bot can delete messages sent by the bot.
  property can_delete_sent_messages : Bool | Nil

  # True, if the bot can delete all private messages in managed chats.
  property can_delete_all_messages : Bool | Nil

  # True, if the bot can edit the first and last name of the business account.
  property can_edit_name : Bool | Nil

  # True, if the bot can edit the bio of the business account.
  property can_edit_bio : Bool | Nil

  # True, if the bot can edit the profile photo of the business account.
  property can_edit_profile_photo : Bool | Nil

  # True, if the bot can edit the username of the business account.
  property can_edit_username : Bool | Nil

  # True, if the bot can change the privacy settings pertaining to gifts for the business account.
  property can_change_gift_settings : Bool | Nil

  # True, if the bot can view gifts and the amount of Telegram Stars owned by the business account.
  property can_view_gifts_and_stars : Bool | Nil

  # True, if the bot can convert regular gifts owned by the business account to Telegram Stars.
  property can_convert_gifts_to_stars : Bool | Nil

  # True, if the bot can transfer and upgrade gifts owned by the business account.
  property can_transfer_and_upgrade_gifts : Bool | Nil

  # True, if the bot can transfer Telegram Stars received by the business account to its own account, or use them to upgrade and transfer gifts.
  property can_transfer_stars : Bool | Nil

  # True, if the bot can post, edit and delete stories on behalf of the business account.
  property can_manage_stories : Bool | Nil
end