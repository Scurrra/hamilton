require "json"

# This object contains information about a user that was shared with the bot using a KeyboardButtonRequestUsers button.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::SharedUser
  include JSON::Serializable

  @[JSON::Field(ignore: true)]
  property non_nil_fields : Array(String) = [] of String

  def after_initialize
    {% for field, index in @type.instance_vars.map &.name.stringify %}
    unless @{{field.id}}.nil?
      @non_nil_fields.push({{field}})
    end
    {% end %}

    @non_nil_fields.delete("non_nil_fields")
  end

  # Identifier of the shared user. The bot may not have access to the user and could be unable to use this identifier, unless the user is already known to the bot by some other means.
  property user_id : Int64

  # First name of the user, if the name was requested by the bot.
  property first_name : String | Nil

  # Last name of the user, if the name was requested by the bot.
  property last_name : String | Nil

  # Username of the user, if the username was requested by the bot.
  property username : String | Nil

  # Available sizes of the chat photo, if the photo was requested by the bot.
  property photo : Array(Hamilton::Types::PhotoSize) | Nil
end