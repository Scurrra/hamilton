require "json"

# Describes a service message about a change in the price of paid messages within a chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PaidMessagePriceChanged
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

  # The new number of Telegram Stars that must be paid by non-administrator users of the supergroup chat for each sent message.
  property paid_message_star_count : Int32
end