require "json"

# This object contains information about a chat that was shared with the bot using a KeyboardButtonRequestChat button.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatShared
  include JSON::Serializable

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

  # Identifier of the request.
  property request_id : Int32

  # Identifier of the shared chat. The bot may not have access to the chat and could be unable to use this identifier, unless the chat is already known to the bot by some other means.
  property chat_id : Int32

  # Title of the chat, if the title was requested by the bot.
  property title : String | Nil

  # Username of the chat, if the username was requested by the bot and available.
  property username : String | Nil

  # Available sizes of the chat photo, if the photo was requested by the bot.
  property photo : Array(Hamilton::Types::PhotoSize)
end