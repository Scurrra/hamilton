require "json"

# This object contains information about a chat boost.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatBoost
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

  # Unique identifier of the boost.
  property boost_id : String

  # Point in time (Unix timestamp) when the chat was boosted.
  property add_date : Int32

  # Point in time (Unix timestamp) when the boost will automatically expire, unless the booster's Telegram Premium subscription is prolonged.
  property expiration_date : Int32

  # Source of the added boost.
  property source : Hamilton::Types::ChatBoostSource
end