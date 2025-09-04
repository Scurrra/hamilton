require "json"

# This object represents reaction changes on a message with anonymous reactions.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::MessageReactionCountUpdated
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

  # The chat containing the message.
  property chat : Hamilton::Types::Chat

  # Unique message identifier inside the chat.
  property message_id : Int32

  # Date of the change in Unix time.
  property date : Int32

  # List of reactions that are present on the message.
  property reactions : Array(Hamilton::Types::ReactionCount)
end