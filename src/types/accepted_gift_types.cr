require "json"

# This object describes the types of gifts that can be gifted to a user or a chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::AcceptedGiftTypes
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

  # True, if unlimited regular gifts are accepted.
  property unlimited_gifts : Bool

  # True, if limited regular gifts are accepted.
  property limited_gifts : Bool

  # True, if unique gifts or gifts that can be upgraded to unique for free are accepted.
  property unique_gifts : Bool

  # True, if a Telegram Premium subscription is accepted.
  property premium_subscription : Bool
end