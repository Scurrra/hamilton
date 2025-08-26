require "json"

# Describes the connection of the bot with a business account.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BusinessConnection
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

  # Unique identifier of the business connection.
  property id : String

  # Business account user that created the business connection.
  property user : Hamilton::Types::User

  # Identifier of a private chat with the user who created the business connection.
  property user_chat_id : Int64

  # Date the connection was established in Unix time.
  property date : Int32

  # Rights of the business bot.
  property rights : Hamilton::Types::BusinessBotRights

  # True, if the connection is active.
  property is_enabled : Bool
end