require "json"

# This object is received when messages are deleted from a connected business account.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BusinessMessagesDeleted
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

  # Unique identifier of the business connection.
  property business_connection_id : String

  # Information about a chat in the business account. The bot may not have access to the chat or the corresponding user.
  property chat : Hamilton::Types::Chat

  # The list of identifiers of deleted messages in the chat of the business account.
  property message_ids : Array(Int32)
end