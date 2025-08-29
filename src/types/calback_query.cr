require "json"

# This object represents an incoming callback query from a callback button in an inline keyboard. If the button that originated the query was attached to a message sent by the bot, the field message will be present. If the button was attached to a message sent via the bot (in inline mode), the field `inline_message_id` will be present. Exactly one of the fields data or `game_short_name` will be present.
#
# NOTE: After the user presses a callback button, Telegram clients will display a progress bar until you call `answerCallbackQuery`. It is, therefore, necessary to react by calling `answerCallbackQuery` even if no notification to the user is needed (e.g., without specifying any of the optional parameters).
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::CallbackQuery
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

  # Unique identifier for this query.
  property id : String

  # Sender.
  property from : Hamilton::Types::User

  # Message sent by the bot with the callback button that originated the query.
  property message : Hamilton::Types::MaybeInaccessibleMessage | Nil

  # Identifier of the message sent via the bot in inline mode, that originated the query.
  property inline_message_id : String | Nil

  # Global identifier, uniquely corresponding to the chat to which the message with the callback button was sent. Useful for high scores in games.
  property chat_instance : String

  # Data associated with the callback button. Be aware that the message originated the query can contain no callback buttons with this data.
  property data : String | Nil

  # Short name of a Game to be returned, serves as the unique identifier for the game.
  property game_short_name : String | Nil
end