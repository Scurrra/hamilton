require "json"

# This object represents an incoming inline query. When the user sends an empty query, your bot could return some default or trending results.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InlineQuery
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

  # Text of the query (up to 256 characters).
  property query : String

  # Offset of the results to be returned, can be controlled by the bot.
  property offset : String

  # Type of the chat from which the inline query was sent. Can be either “sender” for a private chat with the inline query sender, “private”, “group”, “supergroup”, or “channel”. The chat type should be always known for requests sent from official clients and most third-party clients, unless the request was sent from a secret chat.
  property chat_type : String | Nil

  # Sender location, only for bots that request user location.
  property location : Hamilton::Types::Location | Nil
end