require "json"

# Describes a service message about a change in the price of direct messages sent to a channel chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::DirectMessagePriceChanged
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

  # True, if direct messages are enabled for the channel chat; false otherwise
  property are_direct_messages_enabled : Bool

  # The new number of Telegram Stars that must be paid by users for each direct message sent to the channel. Does not apply to users who have been exempted by administrators. Defaults to 0.
  property direct_message_star_count : Int32 | Nil
end